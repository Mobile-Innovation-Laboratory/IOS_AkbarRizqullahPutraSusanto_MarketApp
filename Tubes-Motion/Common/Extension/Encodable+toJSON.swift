//
//  Encodable+toJSON.swift
//  DummyJSON
//
//  Created by Irham Naufal on 01/02/25.
//

import Foundation

extension Encodable {
    func toJSON() -> [String: Any] {
        guard let data =  try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
              let json = dictionary as? [String: Any] else {
            return [:]
        }
        
        return json
    }
    
    func toJSONData() -> Data {
        guard let data =  try? JSONEncoder().encode(self) else {
            return Data()
        }
        
        return data
    }
}
