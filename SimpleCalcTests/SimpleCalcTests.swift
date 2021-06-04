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
    }
    
    func testGiven1IsDisplay_WhenThePlusIsChoosed_ThenPlusIsAddToDisplay() throws {
        setDisplay("1")
        try calcul.addAPlus()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
    }
        
    func testGiven1IsDisplay_WhenTheMinusIsChoosed_ThenMinusIsAddToDisplay() throws {
        setDisplay("1")
        try calcul.addAMinus()
        XCTAssertEqual(calcul.elementsToDisplay, "1 - ")
    }
    
    func testGiven1IsDisplay_WhenTheMultiplyIsChoosed_ThenMultiplyIsAddToDisplay() throws {
        setDisplay("1")
        try calcul.addAMultiply()
        XCTAssertEqual(calcul.elementsToDisplay, "1 x ")
    }
    
    func testGiven1IsDisplay_WhenTheDivideIsChoosed_ThenDivideIsAddToDisplay() throws {
        setDisplay("1")
        try calcul.addADivide()
        XCTAssertEqual(calcul.elementsToDisplay, "1 / ")
    }
    
//====================================================================
//    MARK: Calculation tests

    
    func testGiven1Plus1IsDisplay_WhenTheEqualIsChoosed_Then2IsDisplay() throws {
        setDisplay("1 + 1")
        try calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1 = 2")
    }
    
    func testGiven1Minus1IsDisplay_WhenTheEqualIsChoosed_Then0IsDisplay() throws {
        setDisplay("1 - 1")
        try calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "1 - 1 = 0")
    }
    
    func testGiven2Times2IsDisplay_WhenTheEqualIsChoosed_Then4IsDisplay() throws {
        setDisplay("2 x 2")
        try calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "2 x 2 = 4")
    }
    
    func testGiven4Plus2Times6IsDisplay_WhenTheEqualIsChoosed_Then16IsDisplay() throws {
        setDisplay("4 + 2 x 6")
        try calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "4 + 2 x 6 = 16")
    }
    
    func testGiven2DividesBy2IsDisplay_WhenTheEqualIsChoosed_Then1IsDisplay() throws {
        setDisplay("2 / 2")
        try calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "2 / 2 = 1")
    }
    
    func testGiven4Plus16DividesBy4IsDisplay_WhenTheEqualIsChoosed_Then8IsDisplay() throws {
        setDisplay("4 + 16 / 4")
        try calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "4 + 16 / 4 = 8")
    }
    
    func testGiven16DivideBy4MultiplyBy8Multiply6DivideBy2BIsDisplay_WhenTheEqualIsChoosed_Then96IsDisplay() throws {
        setDisplay("16 / 4 x 8 x 6 / 2")
        try calcul.calculate()
        XCTAssertEqual(calcul.elementsToDisplay, "16 / 4 x 8 x 6 / 2 = 96")
    }
    
    func testGiven1Plus1Equal2IsDisplay_When1IsChoosed_ThenTheCalculIsReset() {
        setDisplay("1 + 1 = 2")
        calcul.addANumber("1")
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
//====================================================================
//    MARK: Error Notification Tests
    
    func testGiven1PlusIsDisplay_WhenPlusIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() throws {
        setDisplay("1 + ")
        XCTAssertThrowsError(try calcul.addAPlus(), "The calculation can not have two operators in a row.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.operandAlreadyChoosed)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
    }
    
    func testGiven1MinusIsDisplay_WhenMinusIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() throws {
        setDisplay("1 - ")
        XCTAssertThrowsError(try calcul.addAMinus(), "The calculation can not have two operators in a row.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.operandAlreadyChoosed)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1 - ")
    }
    
    func testGiven1MultiplyIsDisplay_WhenMultiplyIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() throws {
        setDisplay("1 x ")
        XCTAssertThrowsError(try calcul.addAMultiply(), "The calculation can not have two operators in a row.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.operandAlreadyChoosed)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1 x ")
    }
    
    func testGiven1DivideIsDisplay_WhenDivideIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() throws {
        setDisplay("1 / ")
        XCTAssertThrowsError(try calcul.addADivide(), "The calculation can not have two operators in a row.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.operandAlreadyChoosed)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1 / ")
    }

    func testGiven1PlusIsDisplay_WhenEqualIsChoosed_ThenTheErrorExpressionNotCorrectIsSend() throws {
        setDisplay("1 + ")
        XCTAssertThrowsError(try calcul.calculate(), "The calculation has to be at least one number, one operator, one number.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.expressionNotCorrect)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
    }
    
    func testGiven1IsDisplay_WhenTheEqualIsChoosed_ThenErrorExpressionNotLongEnoughtIsSend() throws {
        setDisplay("1")
        XCTAssertThrowsError(try calcul.calculate(), "The calculation has to be at least one number, one operator, one number.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.expressionNotEnoughtLong)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
    
    func testGiven1Plus1Equal2IsDisplay_WhenEqualIsChoosed_ThenErrorIsSend() throws {
        setDisplay("1 + 1 = 2")
        XCTAssertThrowsError(try calcul.calculate(), "The calculation is already done.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.expressionNotCorrect)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1 = 2")
    }
    
    func testGiven1DivideBy0IsDisplay_When0IsChoosed_ThenErrorDivideByZeroIsSend() throws {
        setDisplay("1 / 0.0")
        XCTAssertThrowsError(try calcul.calculate(), "The calculation have to be at least one number, one operator, one number.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.divideByZero)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1 / 0.0")
    }
    
    //====================================================================
    //    MARK: Non-requested features Tests
    
    func testGiven1DivideIsDisplay_When0IsChoosed_Then1DivideByZeroPointIsDisplay() {
        setDisplay("1 / ")
        calcul.addANumber("0")
        XCTAssertEqual(calcul.elementsToDisplay, "1 / 0.")
    }
    
    func testGiven1Plus1IsDisplay_WhenEraseIsChoosed_Then1PlusIsDisplay() throws {
        setDisplay("1 + 1")
        try calcul.delete()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + ")
    }
    
    func testGiven1PlusIsDisplay_WhenEraseIsChoosed_Then1IsDisplay() throws {
        setDisplay("1 + ")
        try calcul.delete()
        XCTAssertEqual(calcul.elementsToDisplay, "1")
    }
    
    func testGiven1Plus1Equal2IsDisplay_WhenEraseIsChoosed_Then1Plus1IsDisplay() throws {
        setDisplay("1 + 1 = 2")
        try calcul.delete()
        XCTAssertEqual(calcul.elementsToDisplay, "1 + 1")
    }
    
    func testGivenNothingIsDisplay_WhenEraseIsChoosed_ThenErrorIsDisplay() throws {
        setDisplay("")
        XCTAssertThrowsError(try calcul.delete(), "The calculation is already empty. Nothing to delete.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.expressionNotEnoughtLong)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "")
    }
    
    func testGiven10Plus10Equal20IsDisplay_WhenPlusIsChoosed_Then20PlusIsDisplay() throws {
        setDisplay("10 + 10 = 20")
        try calcul.addAPlus()
        XCTAssertEqual(calcul.elementsToDisplay, "20 + ")
    }
    
    func testGiven1IsDisplay_WhenPointIsChoosed_Then1PointIsDisplay() throws {
        setDisplay("1")
        try calcul.addAPoint()
        XCTAssertEqual(calcul.elementsToDisplay, "1.")
    }
    
    func testGivenNothingIsDisplay_WhenPointIsChoosed_ThenErrorIsSend() throws {
        setDisplay("")
        XCTAssertThrowsError(try calcul.addAPoint(), "A point needs a number before its.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.cantAddAPoint)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "")
    }
    
    func testGiven1Point1IsDisplay_WhenPointIsChoosed_ThenErrorIsSend() throws {
        setDisplay("1.1")
        XCTAssertThrowsError(try calcul.addAPoint(), "A number can not have two points.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.cantAddAPoint)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "1.1")
    }
    
    func testGiven10Plus10Equal20IsDisplay_WhenPointIsChoosed_ThenErrorIsSend() throws {
        setDisplay("10 + 10 = 20")
        XCTAssertThrowsError(try calcul.addAPoint(), "A point can not be added if the result is already display.", { error in
            XCTAssertEqual(error as? Calcul.ErrorType, Calcul.ErrorType.cantAddAPoint)
        })
        XCTAssertEqual(calcul.elementsToDisplay, "10 + 10 = 20")
    }
    
}
