//
//  ExampleDTO.swift
//  MModels
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation

public struct ExampleDTO: Codable, Equatable {

    public let id: String
    public let name: String
    public let hobies: [String]

    public init(
        id: String,
        name: String,
        hobies: [String]
    ) {
        self.id = id
        self.name = name
        self.hobies = hobies
    }

    public static func == (lhs: ExampleDTO, rhs: ExampleDTO) -> Bool {
        lhs.id == rhs.id
    }
}
