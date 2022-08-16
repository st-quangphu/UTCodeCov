//
//  SessionManager+Configuration.swift
//  MANetwork
//
//  Created by MBP0003 on 8/5/21.
//

import Alamofire
import Foundation
import MUtility

extension SessionManager {

    public static func makeWithMajicaConfiguration(
        environment: NetworkEnvironment,
        certificateProvider: CertificateProviderType = LocalCertificateProvider()
    ) -> SessionManager {

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = httpAdditionalHeaders()
        configuration.timeoutIntervalForRequest = 5.0
        configuration.urlCredentialStorage = nil

        if FeatureFlags.enableCertificatePinning {
            let mojicaPolicy: ServerTrustPolicy = .pinCertificates(
                certificates: certificateProvider.certificates(),
                validateCertificateChain: true,
                validateHost: true
            )
            let domain = DomainConfigurator.domain(environment: environment)
            let serverTrustPolicyManager = ServerTrustPolicyManager(policies: [domain: mojicaPolicy])
            return SessionManager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
        } else {
            return SessionManager(configuration: configuration)
        }
    }

    private static func httpAdditionalHeaders() -> HttpHeaders {
        let httpHeaders = SessionManager.defaultHTTPHeaders
        return httpHeaders
    }
}
