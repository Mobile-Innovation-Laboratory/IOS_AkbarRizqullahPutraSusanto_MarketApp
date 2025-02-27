//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import Foundation
import Moya

final class AuthRepository {
    
    private var provider: MoyaProvider<AuthTargetType>
    private var appState = AppState.shared
    
    init(provider: MoyaProvider<AuthTargetType> = .defaultProvider()) {
        self.provider = provider
    }
    
    func login(_ body: LoginRequest) async -> Result<LoginResponse, Error> {
        do {
            let response = try await provider.requestAsync(.login(body), model: LoginResponse.self)
            appState.login(response)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func getMe() async -> Result<UserResponse, Error> {
        do {
            let response = try await provider.requestAsync(.getMe, model: UserResponse.self)
            print("Response Data:", response)
            return .success(response)
        } catch let error as MoyaError {
            if let responseData = try? error.response?.mapJSON() {
                print("Error Response JSON:", responseData)
            }
            return .failure(error)
        } catch {
            return .failure(error)
        }
    }
    
    func editProfile(_ body: UserEditRequest) async -> Result<UserResponse, Error> {
        do {
            let response = try await provider.requestAsync(.editProfile(body), model: UserResponse.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

}
