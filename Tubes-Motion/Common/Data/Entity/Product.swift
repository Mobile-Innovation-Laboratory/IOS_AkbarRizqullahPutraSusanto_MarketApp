//
//  Product.swift
//  DummyJSON
//
//  Created by Irham Naufal on 02/02/25.
//

import Foundation

struct ProductListResponse: Codable {
    var products: [ProductResponse]?
    var total: Int?
    var skip: Int?
    var limit: Int?
}

struct ProductResponse: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var category: String?
    var price: Double?
    var discoountPercentage: Double?
    var rating: Double?
    var stock: Int?
    var tags: [String]?
    var brand: String?
    var sku: String?
    var images: [String]?
    var thumbnail: String?
    
}

struct CategoryResponse: Codable {
    var slug: String?
    var name: String?
}
