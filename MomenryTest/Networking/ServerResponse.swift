//
//  ServerResponse.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import Foundation

struct ServerResponse<Content: Decodable> {
    let statusCode: Int
    let message: String
    let data: Content
}

extension ServerResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case statusCode = "estatus"
        case message = "mensaje"
        case data
    }
}
