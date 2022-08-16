//
//  ServerErrorDTO.swift
//  MModels
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MError

public struct ServerErrorDTO: Error, Codable, LocalizedError {
    public let error: String
    public let errorDescription: String?
}

extension ServerError {
    public convenience init(
        serverErrorDTO: ServerErrorDTO,
        errorCode: Int?,
        underlyingErrorJson: [String: Any]? = nil
    ) {
        self.init(
            message: serverErrorDTO.errorDescription,
            errorCode: errorCode ?? ErrorCode.Server.unknownServerError.rawValue,
            underlyingErrorJson: underlyingErrorJson
        )
    }
}
