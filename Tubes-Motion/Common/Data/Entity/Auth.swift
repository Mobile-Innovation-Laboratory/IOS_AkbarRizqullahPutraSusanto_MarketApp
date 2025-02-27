//
//  Auth.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let id: Int?
    let username: String?
    let email: String?
    let firstName: String?
    let lastName: String?
    let accessToken: String?
    let refreshToken: String?
}
