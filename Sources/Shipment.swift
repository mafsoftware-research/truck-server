//
//  Shipment.swift
//  Truck-Server
//
//  Created by Miguel Fermin on 1/2/17.
//
//

import Foundation

struct Shipment {
    var company: String
    var description: String
    var price: Double
    var weight: Double
    
    init(company: String, description: String, price: Double, weight: Double) {
        self.company = company
        self.description = description
        self.price = price
        self.weight = weight
    }
}

// MARK: - JSON Serialization

extension Shipment {
    init?(data: Data) {
        if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            self.init(json: json)
        } else {
            return nil
        }
    }
    
    init?(json: [String : Any]) {
        guard
            let company = json["company"] as? String,
            let description = json["description"] as? String,
            let price = json["price"] as? Double,
            let weight = json["weight"] as? Double
            else {
                return nil
        }
        self.init(company: company, description: description, price: price, weight: weight)
    }
    
    var json: [String : Any] {
        return ["company": company, "description": description, "price": price, "weight": weight]
    }
    
    var data: Data {
        return try! JSONSerialization.data(withJSONObject: json, options: [])
    }
    
    static func shipments(from data: Data) -> [Shipment] {
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String : Any]] else { return [] }
        return json.flatMap { Shipment(json: $0) }
    }
}

