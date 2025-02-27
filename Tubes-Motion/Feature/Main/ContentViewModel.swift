//
//  ContentViewModel.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    private let authRepository = AuthRepository()
    
    @Published var usernameText = ""
    @Published var passwordText = ""
    
    @Published var isShowAlert = false
    @Published var errorText = ""
    
    @MainActor
    func login(routing: @escaping () -> Void) async {
        isShowAlert = false
        errorText = ""
        
        let result = await authRepository.login(LoginRequest(
            username: usernameText, password: passwordText
        ))
        
        switch result {
        case .success:
            routing()
        case .failure(let error):
            errorText = error.localizedDescription
            isShowAlert = true
        }
    }
    
    @MainActor
    func onAppear(routing: @escaping () -> Void) {
        if AppState.shared.isLogin {
            routing()
        }
    }
}
