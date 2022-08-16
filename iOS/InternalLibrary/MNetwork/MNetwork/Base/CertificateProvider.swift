//
//  CertificateProvider.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Alamofire
import Foundation

/// Classes conforming to this protocol must provide security certificates for certificate pinning.
public protocol CertificateProviderType {
    func certificates() -> [SecCertificate]
}

/// This certificate provider will provide any certificates included in the main bundle of the app using this framework.
/// Make sure to add your security certificates to the appropriate target.
/// those targets would be ModartDev, ModartStaging, or ModartProduction (?)
/// Note that the development certificate is a root certificate while staging/production are intermediates.
public struct LocalCertificateProvider: CertificateProviderType {
    public init() { }
    public func certificates() -> [SecCertificate] {
        // The certificate may get cached in the bundle as part of the build process. So this may pick up both certificates.
        // If that causes an issue, clean the build folder and it should pick up only the appropriate certificate again.
        ServerTrustPolicy.certificates()
    }
}
