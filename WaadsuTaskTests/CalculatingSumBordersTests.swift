//
//  TestCalculatingSumBorders.swift
//  WaadsuTaskTests
//
//  Created by Danil Kovalev on 11.07.2022.
//

import XCTest
@testable import WaadsuTask

class TestCalculatingSumBorders: XCTestCase {
    
    // MARK: - Тестируемый метод
    //
    // calculateSumOfBorders(_: [[[Double]]]) -> Int
    // [MapInteractor.swift:29]
    //
    //
    
    private let interactor = MapInteractor()
    
    func testDistance() throws {
        let inputData = [[[-34.61581730298348, -58.399666693362114], [-34.607199153581846, -58.38348760870634]]]
        let result = interactor.calculateSumOfBorders(inputData)
        XCTAssertEqual(result, 1)
        XCTAssertGreaterThan(result, 0)
    }
}
