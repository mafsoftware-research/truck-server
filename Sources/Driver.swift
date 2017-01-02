//
//  Driver.swift
//  Truck-Server
//
//  Created by Miguel Fermin on 1/2/17.
//
//

import Foundation

struct Driver {
    var name: String
    var rate: Double
    var available: Bool
    
    init(name: String, rate: Double, available: Bool) {
        self.name = name
        self.rate = rate
        self.available = available
    }
}

// MARK: - JSON Serialization

extension Driver {
    init?(data: Data) {
        if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            self.init(json: json)
        } else {
            return nil
        }
    }
    
    init?(json: [String : Any]) {
        guard
            let name = json["name"] as? String,
            let rate = json["rate"] as? Double,
            let available = json["available"] as? Bool
            else {
                return nil
        }
        self.init(name: name, rate: rate, available: available)
    }
    
    var json: [String : Any] {
        return ["name": name, "rate": rate, "available": available]
    }
    
    var data: Data {
        return try! JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    static func drivers(from data: Data) -> [Driver] {
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String : Any]] else { return [] }
        return json.flatMap { Driver(json: $0) }
    }
    
    static func json(from data: Data) -> Any? {
        return (try? JSONSerialization.jsonObject(with: data, options: []))
    }
}
