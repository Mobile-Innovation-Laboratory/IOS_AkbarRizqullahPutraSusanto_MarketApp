//
//  CartView.swift
//  DummyJSON
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.carts) { cart in
                Text(cart.name ?? "No Name")
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

