//
//  ProductsServiceable.swift
//  MomenryTest
//
//  Created by Juan on 14/11/20.
//

import Foundation

protocol ProductsServiceable {
    func getProducts(completion: @escaping (Result<ServerResponse<[Product]>, Error>) -> Void)
}
