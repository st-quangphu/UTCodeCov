//
//  MockLocationService.swift
//  MTestBase
//
//  Created by Tri Nguyen T. [2] on 10/08/2022.
//

import Foundation
import MService
import MModels
import MapKit

public final class MockLocationService: LocationServiceType {
    public var requestPermissionMock: ((((CLAuthorizationStatus) -> Void)?) -> Void)?
    public var searchLocationMock: ((Completion<[MKMapItem]>?) -> Void)?
    public var getCurrentLocationMock: ((Completion<MKMapItem>?) -> Void)?
    public var getLocationMock: ((Completion<MKMapItem>?) -> Void)?

    public var isAuthorized: Bool {
        let success: Set<CLAuthorizationStatus> = [.authorizedWhenInUse, .authorizedAlways]
        return success.contains(authorizationStatus)
    }

    public var authorizationStatus: CLAuthorizationStatus {
        CLLocationManager.authorizationStatus()
    }

    public init() {}

    public func requestPermission(completion: ((CLAuthorizationStatus) -> Void)?) {
        requestPermissionMock?(completion)
    }

    public func searchLocation(by name: String, completion: Completion<[MKMapItem]>?) {
        searchLocationMock?(completion)
    }

    public func getCurrentLcation(completion: Completion<MKMapItem>?) {
        getCurrentLocationMock?(completion)
    }

    public func getLocation(location: CLLocation, completion: Completion<MKMapItem>?) {
        getLocationMock?(completion)
    }
}
