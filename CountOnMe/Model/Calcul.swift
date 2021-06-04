//
//  Model.swift
//  CountOnMe
//
//  Created by Gaël HENROT on 26/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calcul {
    
    var elementsToDisplay: String = ""
    
    private var elements: [String] {
        return elementsToDisplay.split(separator: " ").map { "\($0)" }
    }
    
    private var numbers: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    //MARK:  Error check computed variables and methods
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && !elements.isEmpty
    }
    
    private var expressionHaveResult: Bool {
        return elementsToDisplay.firstIndex(of: "=") != nil
    }
    
    private var expressionHaveAMultiply: Bool {
        return elementsToDisplay.firstIndex(of: "x") != nil
    }
    
    private var expressionHaveADivide: Bool {
        return elementsToDisplay.firstIndex(of: "/") != nil
    }
    
    private var canDelete: Bool {
        return elementsToDisplay != ""
    }
    
    /// This method verifies if a point can be added (have not a result, the last number does not already have a point
    private func canAddAPoint() -> Bool {
        var isANumber = false
        guard !expressionHaveResult else {
            return false
        }
        guard !hasAlreadyAPoint() else {
            return false
        }
        
        // Checks if the last element is a number.
        let last = elementsToDisplay.suffix(1)
        for i in numbers {
            if last == i {
                isANumber = true
            }
        }
        return isANumber
    }
    
    /// This method checks if the last number has already a point.
    private func hasAlreadyAPoint() -> Bool {
        guard let lastElement = elements.last else {
            return false
        }
        if lastElement.contains(".") {
            return true
        } else {
            return false
        }
    }
    
    // MARK: 'Add something to the calculation' methods
    
    /// This method adds a number to the current calculation. It forbids the user to divide by 0.
    func addANumber(_ numberSelected: String) {
        
        //If a calculation is already done (and display), it will be deleted.
        if expressionHaveResult {
            elementsToDisplay = ""
        }
        
        // If the user chooses a 0 after a divide, a point will be automatically added.
        guard !(elementsToDisplay.hasSuffix("/ ") && numberSelected == "0") else {
            elementsToDisplay.append("0.")
            return
        }
        
        elementsToDisplay.append(numberSelected)
    }
    
    /// This method adds an operator to the current calculation. If there is already a calculation, it keeps the result.
    private func addAnOperator(operatorAsString: String) throws {
        
        // Keeps the result of last calculation.
        if expressionHaveResult {
            deleteThePreviousCalculation()
        }
        if canAddOperator {
            elementsToDisplay.append(" " + operatorAsString + " ")
        } else {
            throw ErrorType.cantAddAnOperator
        }
    }
    
    /// This method adds a plus sign to the current calculation.
    func addAPlus() throws {
            try addAnOperator(operatorAsString: "+")
    }
    
    /// This method adds a minus sign to the current calculation.
    func addAMinus() throws {
            try addAnOperator(operatorAsString: "-")
    }
    
    /// This method adds a multiply sign to the current calculation.
    func addAMultiply() throws {
            try addAnOperator(operatorAsString: "x")
    }
    
    /// This method adds a divide sign to the current calculation.
    func addADivide() throws {
            try addAnOperator(operatorAsString: "/")
    }
    
    /// This method add a point (decimal).
    func addAPoint() throws {
       guard canAddAPoint() == true else {
            throw ErrorType.cantAddAPoint
        }
            elementsToDisplay.append(".")
    }
    
    // MARK: 'Modify the calculation' methods
    
    /// This method deletes the last element of the current calculation.
    func delete() throws {
        
        guard canDelete else {
            throw ErrorType.expressionNotEnoughtLong
        }
        
        if elementsToDisplay.last != " " && elementsToDisplay != "" {
            while elementsToDisplay.last != " " && elementsToDisplay != "" {
                elementsToDisplay.removeLast()
            }
            if elementsToDisplay.hasSuffix(" = ") {
                elementsToDisplay.removeLast(3)
            }
        } else if elementsToDisplay.last == " " {
            elementsToDisplay.removeLast(3)
        }
    }
    
    /// This method deletes the previous calculation and keeps the result.
    private func deleteThePreviousCalculation() {
        while !elementsToDisplay.hasPrefix("=") {
            elementsToDisplay.removeFirst()
        }
        elementsToDisplay.removeFirst(2)
    }
    
    /// This function realizes the calculation.
    func calculate() throws {
        
        // Checks if the calculation is not already done.
        guard expressionHaveResult == false else {
            throw ErrorType.expressionNotCorrect
        }
        
        // Checks if the calculation is correct (not finishes by an operator).
        guard expressionIsCorrect else {
            throw ErrorType.expressionNotCorrect
        }
        
        // Checks if the calculation has enought elements.
        guard expressionHaveEnoughElement else {
            throw ErrorType.expressionNotEnoughtLong
        }
        
        // Creates local copy of operations
        var operationsToReduce = elements
        
        // Iterates over operations while an operand still here
        while operationsToReduce.count > 1 {
            
            // Defines the priority of calculation.
            var i = 1
            
            if expressionHaveAMultiply {
                i = (operationsToReduce.firstIndex(of: "x") ?? 1)
            }
            if expressionHaveADivide {
                i = (operationsToReduce.firstIndex(of: "/") ?? 1)
            }
            
            // Defines the range to remove after the elementary calculation.
            let rangeToRemove = i-1...i+1
            
            // Defines both side of elementary calculation.
            let left = Double(operationsToReduce[i-1])!
            let operand = operationsToReduce[i]
            let right = Double(operationsToReduce[i+1])!
            
            var result: Double
            
            // Realizes the calculation according to the operator.
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
                // Forbids the user ti divide by 0.
                guard right != 0 else {
                    throw ErrorType.divideByZero
                }
            default: throw ErrorType.unknownOperator
            }
            // Removes the calculation just done and put the result.
            operationsToReduce.removeSubrange(rangeToRemove)
            operationsToReduce.insert("\(result)", at: i-1)
        }
        elementsToDisplay.append(" = \(operationsToReduce.first!)")
        
        // Removes the useless decimals after the digit.
        if elementsToDisplay.hasSuffix(".0") {
            elementsToDisplay.removeLast(2)
        }
    }
    
    /// This enumeration lists all the type of errors.
    enum ErrorType: Error {
        case cantAddAnOperator, expressionNotCorrect, expressionNotEnoughtLong, divideByZero, unknownOperator, cantAddAPoint
    }    
}
