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
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1 = 2")
    }
    
    func testGiven1Minus1IsDisplay_WhenTheEqualIsChoosed_Then0IsDisplay() {
        setDisplay("1 - 1")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "1 - 1 = 0")
    }
    
    func testGiven2Times2IsDisplay_WhenTheEqualIsChoosed_Then4IsDisplay() {
        setDisplay("2 x 2")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "2 x 2 = 4")
    }
    
    func testGiven4Plus2Times6IsDisplay_WhenTheEqualIsChoosed_Then16IsDisplay() {
        setDisplay("4 + 2 x 6")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "4 + 2 x 6 = 16")
    }
    
    func testGiven2DividesBy2IsDisplay_WhenTheEqualIsChoosed_Then1IsDisplay() {
        setDisplay("2 / 2")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "2 / 2 = 1")
    }
    
    func testGiven4Plus16DividesBy4IsDisplay_WhenTheEqualIsChoosed_Then8IsDisplay() {
        setDisplay("4 + 16 / 4")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "4 + 16 / 4 = 8")
    }
    
    func testGiven16DivideBy4MultiplyBy8Multiply6DivideBy2BIsDisplay_WhenTheEqualIsChoosed_Then96IsDisplay() {
        setDisplay("16 / 4 x 8 x 6 / 2")
        calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "16 / 4 x 8 x 6 / 2 = 96")
    }
    
    func testGiven1Plus1Equal2IsDisplay_When1IsChoosed_ThenTheCalculIsReset() {
        setDisplay("1 + 1 = 2.0")
        calcul.addANumber("1")
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
//====================================================================
//    MARK: Error Notification Tests
    
    func testGiven1PlusIsDisplay_WhenPlusIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 + ")
        calcul.addAPlus()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
    }
    
    func testGiven1MinusIsDisplay_WhenMinusIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 - ")
        calcul.addAMinus()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1 - ")
    }
    
    func testGiven1MultiplyIsDisplay_WhenMultiplyIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 x ")
        calcul.addAMultiply()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1 x ")
    }
    
    func testGiven1DivideIsDisplay_WhenDivideIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 / ")
        calcul.addADivide()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
    }

    func testGiven1PlusIsDisplay_WhenEqualIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() {
        setDisplay("1 + ")
        calcul.calculate()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
    }
    
    func testGiven1IsDisplay_WhenTheEqualIsChoosed_ThenErrorExpressionNotLongEnoughtIsSend() {
        setDisplay("1")
        calcul.calculate()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotLongEnought"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
    
    func testGiven1Plus1Equal2IsDisplay_WhenEqualIsChoosed_ThenErrorIsSend() {
        setDisplay("1 + 1 = 2")
        calcul.calculate()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1 = 2")
    }
    
    func testGiven1DivideIsDisplay_When0IsChoosed_ThenErrorDivideByZeroIsSend() {
        setDisplay("1 / ")
        calcul.addANumber("0")
        XCTAssertEqual(calcul.elementsToDisplay, "1 / 0.")
    }
    
    func testGiven1DivideBy0IsDisplay_When0IsChoosed_ThenErrorDivideByZeroIsSend() {
        setDisplay("1 / 0.0")
        calcul.calculate()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("divideByZero"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1 / 0.0")
    }
    
    //====================================================================
    //    MARK: Non-requested features Tests
    
    func testGiven1Plus1IsDisplay_WhenEraseIsChoosed_Then1PlusIsDisplay() {
        setDisplay("1 + 1")
        calcul.delete()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
    }
    
    func testGiven1PlusIsDisplay_WhenEraseIsChoosed_Then1IsDisplay() {
        setDisplay("1 + ")
        calcul.delete()
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
    
    func testGiven1Plus1Equal2IsDisplay_WhenEraseIsChoosed_Then1Plus1IsDisplay() {
        setDisplay("1 + 1 = 2")
        calcul.delete()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1")
    }
    
    func testGivenNothingIsDisplay_WhenEraseIsChoosed_ThenErrorIsDisplay() {
        setDisplay("")
        calcul.delete()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "")
    }
    
    func testGiven10Plus10Equal20IsDisplay_WhenPlusIsChoosed_Then20PlusIsDisplay() {
        setDisplay("10 + 10 = 20")
        calcul.addAPlus()
        XCTAssertEqual(calcul.elementsToDisplay, "20 + ")
    }
    
    func testGiven1IsDisplay_WhenPointIsChoosed_Then1PointIsDisplay() {
        setDisplay("1")
        calcul.addAPoint()
        XCTAssertEqual(calcul.elementsToDisplay, "1.")
    }
    
    func testGivenNothingIsDisplay_WhenPointIsChoosed_ThenErrorIsSend() {
        setDisplay("")
        calcul.addAPoint()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "")
    }
    
    func testGiven1Point1IsDisplay_WhenPointIsChoosed_ThenErrorIsSend() {
        setDisplay("1.1")
        calcul.addAPoint()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "1.1")
    }
    
    func testGiven10Plus10Equal20IsDisplay_WhenPointIsChoosed_ThenErrorIsSend() {
        setDisplay("10 + 10 = 20")
        calcul.addAPoint()
        XCTAssertNotNil(NotificationCenter.default.post(Notification(name: Notification.Name("expressionNotCorrect"))))
        XCTAssertEqual(calcul.elementsToDisplay, "10 + 10 = 20")
    }
    
}
