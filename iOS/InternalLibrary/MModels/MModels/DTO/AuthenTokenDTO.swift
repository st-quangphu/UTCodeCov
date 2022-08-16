//
//  AuthenTokenDTO.swift
//  MModels
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation

public struct AuthTokenDTO: Codable, Equatable {
    public let accessToken: String
    public let refreshToken: String?
    public let tokenType: String
    public let expiresIn: Int64
}
