//
//  ProductCard.swift
//  DummyJSON
//
//  Created by Irham Naufal on 02/02/25.
//

import SwiftUI

struct ProductCard: View {
    
    let data: ProductResponse
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 0) {
                AsyncImage(
                    url: URL(string: data.thumbnail ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 160)
                            .clipped()
                    } placeholder: {
                        Color.gray
                            .frame(height: 160)
                    }

                VStack(alignment: .leading, spacing: 2) {
                    Text(data.title ?? "")
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundStyle(.black)
                    
                    Text("$ \(String(format: "%.2f", data.price ?? 0))")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .frame(height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
            }
        }
    }
}

#Preview {
    HStack {
        ProductCard(data: .init(title: "iPhone 13 Pro", price: 1099.99, rating: 3.42, thumbnail: "https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/thumbnail.png")) {}
        
        ProductCard(data: .init(title: "iPhone 13 Pro Max Pro Max Pro mans lkk asdaf", price: 1099.99, rating: 3.42, thumbnail: "https://cdn.dummyjson.com/products/images/smartphones/iPhone%2013%20Pro/thumbnail.png")) {}
    }
}
