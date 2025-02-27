//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import Foundation

struct UserResponse: Codable {
    var id: Int?
    var username: String?
    var email: String?
    var phone: String?
    var firstName: String?
    var lastName: String?
    var age: Int?
    var gender: String?
    var image: String?
}

struct UserEditRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
}

