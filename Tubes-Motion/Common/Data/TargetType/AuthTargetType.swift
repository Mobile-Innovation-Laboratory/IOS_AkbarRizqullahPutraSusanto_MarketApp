//
//  AuthTargetType.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import Foundation
import Moya

enum AuthTargetType {
    case login(LoginRequest)
    case getMe
    case editProfile(UserEditRequest)
}

extension AuthTargetType: DefaultTargetType, AccessTokenAuthorizable {
    
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        case .login:
            return .none
        case .getMe:
            return .bearer
        case .editProfile:
            return .none
        }
    }
    
    var path: String {
        switch self {
        case .login:
            "/auth/login"
        case .getMe:
            "/users/1"
        case .editProfile:
            "user/1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getMe:
            return .get
        case .editProfile:
            return .put
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .login(let loginRequest):
            return loginRequest.toJSON()
        case .getMe:
            return [:]
        case .editProfile(let userEditRequest):
            return userEditRequest.toJSON()
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default
        case .getMe:
            return URLEncoding.default
        case .editProfile:
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
