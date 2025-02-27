//
//  ContentView.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var router: AppRouter = .init()
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack(path: $router.routes) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Login first")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Username", text: $viewModel.usernameText)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $viewModel.passwordText)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    Button {
                        Task {
                            await viewModel.login {
                                router.route(to: .bottomnavigation(router))
                            }
                        }
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .padding(4)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .alert("Oopss...", isPresented: $viewModel.isShowAlert) {
                    Button("Okay") {
                        
                    }
                } message: {
                    Text(viewModel.errorText)
                }
                .padding()
                .padding(.vertical, 80)
            }
            .onAppear {
                viewModel.onAppear {
                    router.route(to: .bottomnavigation(router))
                }
            }
            .navigationDestination(for: Route.self) { $0 }
        }
    }
}

#Preview {
    ContentView()
}
