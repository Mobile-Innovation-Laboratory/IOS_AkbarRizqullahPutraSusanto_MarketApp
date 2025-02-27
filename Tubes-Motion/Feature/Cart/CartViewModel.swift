//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//


import SwiftUI
import CoreData

final class CartViewModel: ObservableObject {
    
    private let cartRepository = CartRepository()
    
    @Published var carts: [CartEntity] = []
    @Published var nameCart = ""
    @Published var isSuccess = false
    
    @MainActor
    func createCart(name: String, quantity: String, imageURL: String) async {
        let response = cartRepository.createCart(name: name, quantity: quantity, imageURL: imageURL)
        
        switch response {
        case .success(let success):
            isSuccess = success
            await getCart()
        case .failure(let error):
            print("Error adding to cart: \(error)")
        }
    }
    
    @MainActor
    func getCart() async {
        let response = cartRepository.getCart()
        
        switch response {
        case .success(let cartsData):
            print("Carts fetched: \(cartsData.count)")
            for cart in cartsData {
                print("Cart ID: \(cart.id?.uuidString ?? "nil")")
            }
            carts = cartsData
        case .failure(let error):
            print("Error fetching cart: \(error)")
        }
    }

    
    @MainActor
    func updateCart(id: UUID, quantity: String, imageURL: String) async {
        let response = cartRepository.updateCart(id: id, quantity: quantity, imageURL: imageURL)
        
        switch response {
        case .success(let success):
            if success {
                await getCart() 
            }
        case .failure(let error):
            print("Error updating cart: \(error)")
        }
    }


    
    @MainActor
    func deleteCart(id: UUID) async {
        let response = cartRepository.deleteCart(id: id)
        
        switch response {
        case .success(let success):
            if success {
                await getCart()
            }
        case .failure(let error):
            print("Failed to delete cart: \(error)")
        }
    }
}
