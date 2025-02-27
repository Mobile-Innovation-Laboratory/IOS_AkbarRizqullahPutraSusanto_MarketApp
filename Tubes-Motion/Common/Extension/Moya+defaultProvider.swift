//
//  Persistence.swift
//  Tubes-Motion
//
//  Created by Akbar Rizqullah on 27/02/25.
//

import Foundation
import Moya

extension MoyaProvider {
    static func defaultProvider() -> MoyaProvider {
        let appState = AppState.shared

        let accessTokenPlugin = AccessTokenPlugin(tokenClosure: { _ in
            appState.getToken ?? ""
        })
        
        return MoyaProvider(plugins: [
            NetworkLoggerPlugin(),
            accessTokenPlugin
        ])
    }
}
