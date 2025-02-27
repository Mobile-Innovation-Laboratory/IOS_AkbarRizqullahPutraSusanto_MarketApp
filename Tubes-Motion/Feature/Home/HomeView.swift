//
//  HomeView.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @StateObject var router: AppRouter
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Dummy JSON")
                .font(.headline)
                .padding()
            
            ScrollView {
                VStack {
                    categorySection
                    
                    productListSection
                
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("")
    }
}

extension HomeView {
    
    @ViewBuilder
    var categorySection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Chip(
                    text: "All",
                    bgColor: viewModel.currentCategory == "All" ? Color.blue : Color.gray
                ) {
                    viewModel.currentCategory = "All"
                    viewModel.getProductList()
                }
                
                ForEach(viewModel.categories, id: \.slug) { item in
                    Chip(
                        text: item.name ?? "",
                        bgColor: viewModel.currentCategory == item.name ?? "" ? Color.blue : Color.gray
                    ) {
                        viewModel.currentCategory = item.name ?? ""
                        viewModel.getProductListByCategory(item.slug ?? "")
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    var productListSection: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 120), spacing: 12), count: 2), spacing: 12) {
            ForEach(viewModel.products, id: \.id) { item in
                ProductCard(data: item) {
                    if let id = item.id {
                        router.route(to: .productDetail(ProductDetailViewModel(id: id)))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView(router: .init())
}
