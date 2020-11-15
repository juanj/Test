//
//  Product.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import Foundation

struct Product: Equatable {
    let url: String
    let name: String
}

extension Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case name = "nombre"
    }
}
