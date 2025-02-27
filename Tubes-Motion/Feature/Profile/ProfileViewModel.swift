//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: UserResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: AuthRepository

    init(repository: AuthRepository = AuthRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func fetchUser() async {
        isLoading = true
        defer { isLoading = false }
        
        let result = await repository.getMe()
        
        switch result {
        case .success(let user):
            self.user = user
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }

}
