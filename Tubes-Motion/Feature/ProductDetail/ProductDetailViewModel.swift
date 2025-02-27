//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import SwiftUI

@MainActor
final class ProductDetailViewModel: ObservableObject {
    
    private let id: Int
    
    // TODO: Add `ProductRepository`
    private let productDetailRepository = ProductRepository()
    
    @Published var product: ProductResponse?
    
    init(id: Int) {
        self.id = id
    }
    
    func getProduct() {
        Task {
            // TODO: Implementation
            let result = await productDetailRepository.getProductDetail(id: id)
            
            switch result {
            case .success(let success):
                product = success
            case .failure(let failure):
                print("Error \(failure)")
            }
        }
    }
}
