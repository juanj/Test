//
//  ProductTests.swift
//  MomenryTestTests
//
//  Created by Juan on 14/11/20.
//

import XCTest
@testable import MomenryTest

class ProductTests: XCTestCase {
    func testDecode_withValidJSON_decodesObject() {
        let json = """
        {
            "nombre": "producto",
            "url": "test.com/producto"
        }
        """

        let decoder = JSONDecoder()
        let object = try! decoder.decode(Product.self, from: json.data(using: .utf8)!) // swiftlint:disable:this force_try

        XCTAssert(object == Product(url: "test.com/producto", name: "producto"))
    }

    func testDecode_withJSONMissingNombre_throwsError() {
        let json = """
        {
            "url": "test.com/producto"
        }
        """

        let decoder = JSONDecoder()
        XCTAssertThrowsError(try decoder.decode(Product.self, from: json.data(using: .utf8)!))
    }

    func testDecode_withJSONMissingURL_throwsError() {
        let json = """
        {
            "nombre": "producto"
        }
        """

        let decoder = JSONDecoder()
        XCTAssertThrowsError(try decoder.decode(Product.self, from: json.data(using: .utf8)!))
    }
}
