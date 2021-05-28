//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculTests: XCTestCase {
    var calcul: Calcul!
    override func setUp() {
        super.setUp()
        calcul = Calcul()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setDisplay(_ calculation: String) {
        calcul.elementsToDisplay = (calculation)
    }

    func testGivenNothingHasBeenDone_WhenTheNumber1IsChoosed_Then1IsDisplay() {
        calcul.addANumber("1")
        XCTAssertEqual(calcul.elementsToDisplay.last, "1")
//        XCTAssertEqual(calcul.elements.last, "1")
    }
    
    func testGiven1IsDisplay_WhenThePlusIsChoosed_ThenPlusIsAddToDisplay() {
        setDisplay("1")
        calcul.addAPlus()
        XCTAssertEqual(calcul.elementsToDisplay.suffix(2), "+ ")
//        XCTAssertEqual(calcul.elements.last, "+ ")
    }
        
    func testGiven1IsDisplay_WhenTheMinusIsChoosed_ThenMinusIsAddToDisplay() {
        setDisplay("1")
        calcul.addAMinus()
        XCTAssertEqual(calcul.elementsToDisplay.suffix(2), "- ")
    }
    func testGiven1Plus1IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() {
        setDisplay("1 + 1")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1 = 2")
    }
    
    func testGiven1Minus1IsDisplay_WhenTheEqualIsChoosed_Then0IsDisplay() {
        setDisplay("1 - 1")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "1 - 1 = 0")
    }
    
    func testGiven1Plus1Equal2IsDisplay_When1IsChoosed_ThenTheCalculIsReset() {
        setDisplay("1 + 1 = 2")
        calcul.addANumber("1")
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
    
    func testGiven1PlusIsDisplay_WhenPlusIsChoosed_ThenTheErrorIsDisplay() {
        setDisplay("1 + ")
        calcul.addAPlus()
        XCTAssertNotNil(calcul.addAPlus)
    }
    
    func testGiven1PlusIsDisplay_WhenMinusIsChoosed_ThenTheErrorIsDisplay() {
        setDisplay("1 + ")
        calcul.addAMinus()
        XCTAssertNotNil(calcul.addAMinus)
    }


    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
