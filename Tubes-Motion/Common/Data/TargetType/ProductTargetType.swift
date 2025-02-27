//
//  ProductTargetType.swift
//  DummyJSON
//
//  Created by Irham Naufal on 02/02/25.
//

import Foundation
import Moya

enum ProductTargetType {
    case getCategories
    case getProductList
    case getProductDetail(Int)
    case getProductListByCategory(String)
}

extension ProductTargetType: DefaultTargetType, AccessTokenAuthorizable {
    
    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }
    
    var path: String {
        switch self {
        case .getProductList: "/products"
        case .getProductDetail(let id): "/products/\(id)"
        case .getCategories: "/products/categories"
        case .getProductListByCategory(let category): "/products/category/\(category)"
        default: ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        default: return [:]
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        default: return URLEncoding.default
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
