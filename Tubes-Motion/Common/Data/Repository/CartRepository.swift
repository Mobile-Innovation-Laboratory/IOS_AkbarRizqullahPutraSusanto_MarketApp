//
//  CartRepository.swift
//  DummyJSON
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import CoreData
import Foundation

final class CartRepository{
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        self.viewContext = viewContext
    }
    
    func createCart(name: String) -> Result<Bool, Error> {
        let cart = CartEntity(context: viewContext)
        cart.id = UUID()
        cart.name = name

        do {
            try viewContext.save()
            return .success(true)
        } catch {
            print("Error saving cart: \(error)")
            return .failure(error)
        }
    }

    
    
    func getCart(searchText: String? = nil) -> Result<[Cart], Error>{
        let fetchRequest: NSFetchRequest<CartEntity> = CartEntity.fetchRequest()
        
        if let searchText = searchText{
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        }
        
        do{
            let result = try viewContext.fetch(fetchRequest)
            
            let response = result.map{ entity in
                Cart(
                    id: entity.id!,
                    name: entity.name
                )
            }
            return .success(response)
        }catch{
            return .failure(error)
        }
    }
}
