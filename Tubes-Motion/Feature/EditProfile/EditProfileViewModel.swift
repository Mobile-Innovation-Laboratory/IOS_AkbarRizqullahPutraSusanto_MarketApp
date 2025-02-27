//
//  EditProfileViewModel.swift
//  DummyJSON
//
//  Created by Akbar Rizqullah on 26/02/25.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    
    @Published var username: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage: String?
    @Published var success = false

    private let repository: AuthRepository

    init(user: UserResponse, repository: AuthRepository = AuthRepository()) {
        self.username = user.username ?? ""
        self.firstName = user.firstName ?? ""
        self.lastName = user.lastName ?? ""
        self.email = user.email ?? ""
        self.repository = repository
    }
    
    @MainActor
    func updateProfile() async {
        isLoading = true
        defer { isLoading = false }
        
        let request = UserEditRequest(firstName: firstName, lastName: lastName, email: email)
        let result = await repository.editProfile(request)
        
        switch result {
        case .success:
            success = true
        case .failure(let error):
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
