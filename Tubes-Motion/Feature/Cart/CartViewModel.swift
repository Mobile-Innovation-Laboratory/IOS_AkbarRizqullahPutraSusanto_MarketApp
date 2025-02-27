//
//  CartViewModel.swift
//  DummyJSON
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import SwiftUI

final class CartViewModel: ObservableObject {
    private let cartRepository: CartRepository = CartRepository()
    
    
    @Published var carts: [Cart] = []
    
    @Published var searchText = ""
    @Published var nameCart = ""
    @Published var isSucces = false
    
    @Published var ishowmodal = false
    
    @MainActor
    func createCart() async {
        let response = cartRepository.createCart(name: nameCart)
        
        switch response {
        case .success(let succes):
            isSucces = succes
        case .failure(let failure):
            print(failure)
        }
    }
    
    @MainActor
    func createCart2() async {
        do {
            try cartRepository.createCart(name: nameCart)
            isSucces = true
        }catch{
            print(error)
        }
    }
    
    @MainActor
    func getCart() async {
        let response = cartRepository.getCart(searchText: searchText)
        
        switch response {
        case .success(let succes):
            carts = succes
        case .failure(let failure):
            print(failure)
        }
    }
    
    @MainActor
    func addToCart(name: String) async {
        let response = cartRepository.createCart(name: name)
        
        switch response {
        case .success(let success):
            if success {
                await getCart() // Refresh daftar cart setelah menambahkan item
            }
        case .failure(let failure):
            print("Failed to add to cart: \(failure)")
        }
    }

}
