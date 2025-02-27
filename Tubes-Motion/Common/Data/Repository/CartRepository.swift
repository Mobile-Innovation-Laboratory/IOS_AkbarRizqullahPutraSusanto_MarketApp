//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import CoreData
import Foundation

final class CartRepository {
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func createCart(name: String, quantity: String, imageURL: String) -> Result<Bool, Error> {
        let cart = CartEntity(context: viewContext)
        cart.id = UUID()
        cart.name = name
        cart.quantity = quantity
        cart.imageURL = imageURL
        
        do {
            try viewContext.save()
            return .success(true)
        } catch {
            print("Error saving cart: \(error)")
            return .failure(error)
        }
    }
    
    func getCart(searchText: String? = nil) -> Result<[CartEntity], Error> {
        let fetchRequest: NSFetchRequest<CartEntity> = CartEntity.fetchRequest()
        
        if let searchText = searchText, !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        }
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return .success(result)
        } catch {
            print("Error fetching cart: \(error)")
            return .failure(error)
        }
    }

    func updateCart(id: UUID, quantity: String, imageURL: String) -> Result<Bool, Error> {
        let fetchRequest: NSFetchRequest<CartEntity> = CartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let result = try viewContext.fetch(fetchRequest)
            if let cartToUpdate = result.first {
                guard let newQty = Int(quantity), newQty > 0 else {
                    return .failure(NSError(domain: "Invalid Quantity", code: 400, userInfo: nil))
                }
                
                cartToUpdate.quantity = "\(newQty)"  
                cartToUpdate.imageURL = imageURL
                try viewContext.save()
                
                return .success(true)
            }
            return .success(false)
        } catch {
            return .failure(error)
        }
    }


    
    func deleteCart(id: UUID) -> Result<Bool, Error> {
        let fetchRequest: NSFetchRequest<CartEntity> = CartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let cartToDelete = result.first {
                viewContext.delete(cartToDelete)
                try viewContext.save()
                return .success(true)
            }
            return .success(false)
        } catch {
            return .failure(error)
        }
    }
}
