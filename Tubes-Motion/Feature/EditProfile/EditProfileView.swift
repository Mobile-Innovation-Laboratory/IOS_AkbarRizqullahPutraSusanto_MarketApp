//
//  EditProfileView.swift
//  DummyJSON
//
//  Created by Akbar Rizqullah on 26/02/25.
//

import SwiftUI

struct EditProfileView: View {
    
    @StateObject var viewModel: EditProfileViewModel
    @Environment(\.dismiss) var dismiss
    var onProfileUpdated: ((UserResponse) -> Void)?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Username", text:$viewModel.username)
                    TextField("First Name", text:$viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                    TextField("Email", text: $viewModel.email).keyboardType(.emailAddress)
                }
                
                Section {
                    Button(action: {
                        Task {
                            await viewModel.updateProfile()
                            if viewModel.success {
                                let updatedUser = UserResponse(
                                    email: viewModel.email, firstName: viewModel.firstName,
                                    lastName: viewModel.lastName
                                )
                                onProfileUpdated?(updatedUser)
                                dismiss()
                            }
                        }
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Save Changes")
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Update Failed", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "Something went wrong")
            }
        }
    }
}


#Preview {
    EditProfileView(viewModel: EditProfileViewModel(user: UserResponse(email: "john.doe@example.com", firstName: "John", lastName: "Doe")))
}
