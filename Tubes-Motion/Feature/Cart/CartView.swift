//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//


import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.carts, id: \.id) { cart in
                    HStack {
                        Text(cart.name ?? "No Name")
                        Spacer()
                        Button(action: {
                            Task {
                                await viewModel.deleteCart(id: cart.id!)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.getCart()
                }
            }
            .navigationTitle("Cart")
        }
    }
}

#Preview {
    CartView()
}



