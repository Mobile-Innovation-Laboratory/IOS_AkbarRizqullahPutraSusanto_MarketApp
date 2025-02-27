//
//  ProfileView.swift
//  DummyJSON
//
//  Created by Akbar Rizqullah on 26/02/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @StateObject var router: AppRouter
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let user = viewModel.user {
                    profileDetail(user: user)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchUser()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isEditing) {
                if let user = viewModel.user {
                    EditProfileView(viewModel: EditProfileViewModel(user: user)) { updatedUser in
                        viewModel.user = updatedUser
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func profileDetail(user: UserResponse) -> some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: user.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())

            
            Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                .font(.title)
                .bold()
            
            Text("Username: \(user.username ?? "N/A")")
                .font(.body)
            
            Text("Email: \(user.email ?? "N/A")")
                .font(.body)
            
//            Text("Phone: \(user.phone ?? "N/A")")
//                .font(.body)
//            
//            Text("Age: \(user.age ?? 0) years")
//                .font(.body)
//            
//            Text("Gender: \(user.gender ?? "N/A")")
//                .font(.body)
            
            Spacer()
            
            HStack {
                Button {
                    isEditing = true
                } label: {
                    Text("Edit")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Button {
                    AppState.shared.logout()
                    router.backToRoot()
                } label: {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 32)
    }
}

#Preview {
    ProfileView(router: .init())
}
