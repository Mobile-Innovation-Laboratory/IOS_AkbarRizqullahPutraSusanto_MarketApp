//
//  HomeViewModel.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    
    private let productRepository = ProductRepository()
    
    @Published var categories: [CategoryResponse] = []
    @Published var currentCategory = "All"
    
    @Published var products: [ProductResponse] = []
    
    init() {
        getCategories()
        getProductList()
    }
    
    func getCategories() {
        Task {
            let result = await productRepository.getCategories()
            
            switch result {
            case .success(let response):
                withAnimation {
                    self.categories = response
                }
                
            case .failure(let failure):
                print("HOME VIEW MODEL ERROR: \(failure)")
            }
        }
    }
    
    func getProductList() {
        Task {
            // TODO: Implementation
            let result = await productRepository.getProductList()
            
            switch result {
            case .success(let responese):
                products = responese.products ?? []
            case .failure(let failure):
                print("HOME VIEW MODEL ERROR: \(failure)")
            }
        }
    }
    
    func getProductListByCategory(_ category: String) {
        Task {
            let result = await productRepository.getProductListByCategory(category: category)
            
            switch result {
            case .success(let response):
                withAnimation {
                    self.products = response.products ?? []
                }

            case .failure(let failure):
                print("HOME VIEW MODEL ERROR: \(failure)")
            }
        }
    }
}
