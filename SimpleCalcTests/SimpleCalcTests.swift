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
//====================================================================
//    MARK: Test methods
    
    func setDisplay(_ calculation: String) {
        calcul.elementsToDisplay = calculation
    }
//====================================================================
//    MARK: Standard situations tests
    
    func testGivenNothingHasBeenDone_WhenTheNumber1IsChoosed_Then1IsDisplay() {
        calcul.addANumber("1")
        XCTAssertEqual(calcul.elementsToDisplay, "1")
//        XCTAssertEqual(calcul.elements.last, "1")
    }
    
    func testGiven1IsDisplay_WhenThePlusIsChoosed_ThenPlusIsAddToDisplay() {
        setDisplay("1")
        calcul.addAPlus()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
//        XCTAssertEqual(calcul.elements.last, "+ ")
    }
        
    func testGiven1IsDisplay_WhenTheMinusIsChoosed_ThenMinusIsAddToDisplay() {
        setDisplay("1")
        calcul.addAMinus()
        XCTAssertEqual(calcul.elementsToDisplay, "1 - ")
    }
    
    func testGiven1IsDisplay_WhenTheMultiplyIsChoosed_ThenMultiplyIsAddToDisplay() {
        setDisplay("1")
        calcul.addAMultiply()
        XCTAssertEqual(calcul.elementsToDisplay, "1 x ")
    }
    
    func testGiven1IsDisplay_WhenTheDivideIsChoosed_ThenDivideIsAddToDisplay() {
        setDisplay("1")
        calcul.addADivide()
        XCTAssertEqual(calcul.elementsToDisplay, "1 / ")
    }
    
//====================================================================
//    MARK: Calculation tests

    
    func testGiven1Plus1IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() {
        setDisplay("1 + 1")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1 = 2.0")
    }
    
    func testGiven1Minus1IsDisplay_WhenTheEqualIsChoosed_Then0IsDisplay() {
        setDisplay("1 - 1")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "1 - 1 = 0.0")
    }
    
    func testGiven2Times2IsDisplay_WhenTheEqualIsChoosed_Then4IsDisplay() {
        setDisplay("2 x 2")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "2 x 2 = 4.0")
    }
    
    func testGiven4Plus2Times6IsDisplay_WhenTheEqualIsChoosed_Then16IsDisplay() {
        setDisplay("4 + 2 x 6")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "4 + 2 x 6 = 16.0")
    }
    
    func testGiven2DividesBy2IsDisplay_WhenTheEqualIsChoosed_Then1IsDisplay() {
        setDisplay("2 / 2")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "2 / 2 = 1.0")
    }
    
    func testGiven4Plus16DividesBy4IsDisplay_WhenTheEqualIsChoosed_Then8IsDisplay() {
        setDisplay("4 + 16 / 4")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "4 + 16 / 4 = 8.0")
    }
    
    func testGiven1Plus1Equal2IsDisplay_When1IsChoosed_ThenTheCalculIsReset() {
        setDisplay("1 + 1 = 2")
        calcul.addANumber("1")
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
//====================================================================
//    MARK: Eror Notification Tests
    
    func testGiven1PlusIsDisplay_WhenPlusIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 + ")
        calcul.addAPlus()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
    }
    
    func testGiven1PlusIsDisplay_WhenMinusIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 + ")
        calcul.addAMinus()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
    }
    
    func testGiven1PlusIsDisplay_WhenMultiplyIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 + ")
        calcul.addAMultiply()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
    }

    func testGiven1PlusIsDisplay_WhenEqualIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 + ")
        calcul.calculate()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
    }
    
    func testGiven1IsDisplay_WhenTheEqualIsChoosed_ThenErrorExpressionNotLongEnoughtIsSend() {
        setDisplay("1")
        calcul.calculate()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotLongEnought"))))
    }
    
    func testGiven1Plus1Equal2IsDisplay_WhenEqualIsChoosed_ThenErrorIsSend() {
        setDisplay("1 + 1 = 2")
        calcul.calculate()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
    }
    
    func testGiven1DivideIsDisplay_When0IsChoosed_ThenErrorIsSend() {
        setDisplay("1 / ")
        calcul.addANumber("0")
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("divideByZero"))))
    }

    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
