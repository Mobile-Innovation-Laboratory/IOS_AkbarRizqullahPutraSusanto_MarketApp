//
//  Reusable.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import Foundation

struct SuccessResponse: Codable {
    let message: String?
}

struct ErrorResponse: Codable, Error {
    let statusCode: Int?
    let message: String?
    var localizedDescription: String { message ?? "Unknown error" }
}
