//
//  AppState.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import SwiftUI

final class AppState {
    
    static let shared = AppState()
    
    private init() {}
    
    var isLogin: Bool {
        UserDefaults.standard.bool(forKey: "isLogin")
    }
    
    func setLogin(_ isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: "isLogin")
    }
    
    var getToken: String? {
        UserDefaults.standard.string(forKey: "token")
    }
    
    func setToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    var getRefreshToken: String? {
        UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    func setRefreshToken(_ refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
    }
    
    func login(_ body: LoginResponse) {
        if let accessToken = body.accessToken,
           let refreshToken = body.refreshToken {
            setToken(accessToken)
            setRefreshToken(refreshToken)
            setLogin(true)
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
    }
}
