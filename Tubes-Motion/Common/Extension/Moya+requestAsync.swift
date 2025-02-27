//
//  Moya+requestAsync.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import Foundation
import Moya

extension MoyaProvider {
    func requestAsync<T: Codable>(_ target: Target, model: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .failure(let moyaError):
                    continuation.resume(throwing: moyaError)
                    print(moyaError)
                case .success(let response):
                    if response.statusCode >= 200 && response.statusCode < 300 {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .iso8601
                        
                        do {
                            let decodedData = try jsonDecoder.decode(model.self, from: response.data)
                            continuation.resume(returning: decodedData)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    } else {
                        continuation.resume(throwing: ErrorResponse(
                            statusCode: response.statusCode, message: "Something went worng"
                        ))
                    }
                }
            }
        }
    }
}
