//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import Foundation
import Moya

final class ProductRepository {
    
    private var provider: MoyaProvider<ProductTargetType>
    
    init(provider: MoyaProvider<ProductTargetType> = .defaultProvider()) {
        self.provider = provider
    }
    
    func getCategories() async -> Result<[CategoryResponse], Error> {
        do {
            let response = try await provider.requestAsync(.getCategories, model: [CategoryResponse].self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
  func getProductList() async -> Result<ProductListResponse, Error>{
        do {
            let response = try await provider.requestAsync(.getProductList, model: ProductListResponse.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    // TODO: func getProductDetail(id: Int) async -> Result<ProductResponse, Error>
    func getProductDetail(id: Int) async -> Result<ProductResponse, Error>{
        do{
            let response = try await provider.requestAsync(.getProductDetail(id), model: ProductResponse.self)
            return .success(response)
        }catch{
            return .failure(error)
        }
    }
    
    // TODO: func getProductListByCategory(category: String) async -> Result<ProductListResponse, Error>
    func getProductListByCategory(category: String) async -> Result<ProductListResponse, Error> {
        do {
            let response = try await provider.requestAsync(.getProductListByCategory(category), model: ProductListResponse.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
