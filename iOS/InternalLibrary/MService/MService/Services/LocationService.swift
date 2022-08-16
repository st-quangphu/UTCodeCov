//
//  LocationService.swift
//  MService
//
//  Created by Long Vo M. on 7/15/22.
//

import Foundation
import MModels
import MNetwork
import MapKit
import MError
// swiftlint:disable line_length
public protocol LocationServiceType {
    var isAuthorized: Bool { get }
    var authorizationStatus: CLAuthorizationStatus { get }

    func requestPermission(completion: ((CLAuthorizationStatus) -> Void)?)
    func searchLocation(by name: String, completion: Completion<[MKMapItem]>?)
    func getCurrentLcation(completion: Completion<MKMapItem>?)
    func getLocation(location: CLLocation, completion: Completion<MKMapItem>?)
}

public class LocationService: NSObject {
    let locationManager = CLLocationManager()
    var completion: Completion<CLLocation>?
    var completionPermission: ((CLAuthorizationStatus) -> Void)?
    var location = CLLocation()

    public override init() {
    }
}

extension LocationService: LocationServiceType {
    public func getCurrentLcation(completion: Completion<MKMapItem>?) {
        guard let sourcelocation = self.locationManager.location else { return }
        getLocation(location: sourcelocation) { result in
            completion?(result)
        }
    }

    public func getLocation(location: CLLocation, completion: Completion<MKMapItem>?) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemarks = placemarks, !placemarks.isEmpty {
                if let placemark = placemarks.last {
                    let loca = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                    completion?(.success(loca))
                } else if let error = error {
                    completion?(.failure(MError(error: error)))
                }
            }
        }
    }

    public var isAuthorized: Bool {
        let success: Set<CLAuthorizationStatus> = [.authorizedWhenInUse, .authorizedAlways]
        return success.contains(authorizationStatus)
    }

    public var authorizationStatus: CLAuthorizationStatus {
        CLLocationManager.authorizationStatus()
    }

    public func requestPermission(completion: ((CLAuthorizationStatus) -> Void)?) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            self.completionPermission = completion
        } else {
            completion?(authorizationStatus)
        }
    }

    public func searchLocation(by name: String, completion: Completion<[MKMapItem]>?) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = name

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            DispatchQueue.main.async {
                guard let response = response else {
                    let e = MError(errorType: .generic, errorCode: error?.code ?? 500)
                    completion?(.failure(e))
                    return
                }
                var items: [MKMapItem] = []
                items = response.mapItems

                completion?(.success(items))
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        completion?(.success(userLocation))
        locationManager.stopUpdatingLocation()
        guard let latitude = manager.location?.coordinate.latitude, let longitude = manager.location?.coordinate.longitude else { return }
        location = CLLocation(latitude: latitude, longitude: longitude)
        completion = nil
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(MError(error: error)))
        locationManager.stopUpdatingLocation()
        completion = nil
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        completionPermission?(status)
        completionPermission = nil
    }
}
// swiftlint:enable line_length
