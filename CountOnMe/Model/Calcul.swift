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
    
    var elements: [String] {
        return elementsToDisplay.split(separator: " ").map { "\($0)" }
    }
    
    //MARK:  Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
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
    
    // MARK: 'Add something to the calculation' methods
    
    /// This method adds a number to the current calculation. It forbids the user to divide by 0.
    func addANumber(_ numberSelected: String) {
        
        //If a calculation is already done (and display), it will be deleted.
        if expressionHaveResult {
            elementsToDisplay = ""
        }
        
        // Forbids the user to divide by 0.
        guard !(elementsToDisplay.hasSuffix("/ ") && numberSelected == "0") else {
            errorDone(.divideByZero)
            return
        }
        
        elementsToDisplay.append(numberSelected)
    }
    
    /// This method adds an operator to the current calculation. If there is already a calculation, it keeps the result.
    private func addAnOperator(operatorAsString: String) {
        
        // Keeps the result of last calculation.
        if expressionHaveResult {
            deleteThePreviousCalculation()
        }
        if canAddOperator {
            elementsToDisplay.append(" " + operatorAsString + " ")
        } else {
            errorDone(.operandAlreadyChoosed)
        }
    }
    
    /// This method adds a plus sign to the current calculation.
    func addAPlus() {
        addAnOperator(operatorAsString: "+")
    }
    
    /// This method adds a minus sign to the current calculation.
    func addAMinus() {
        addAnOperator(operatorAsString: "-")
    }
    
    /// This method adds a multiply sign to the current calculation.
    func addAMultiply() {
        addAnOperator(operatorAsString: "x")
    }
    
    /// This method adds a divide sign to the current calculation.
    func addADivide() {
        addAnOperator(operatorAsString: "/")
    }
    
    // MARK: 'Modify the calculation' methods
    
    /// This method deletes the last element of the current calculation.
    func delete() {
        
        guard canDelete else {
            errorDone(.expressionNotEnoughtLong)
            return
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
    func calculate() {
        
        // Checks if the calculation is not already done.
        guard expressionHaveResult == false else {
            errorDone(.expressionNotCorrect)
            return
        }
        
        // Checks if the calculation is correct (not finishes by an operator).
        guard expressionIsCorrect else {
            errorDone(.expressionNotCorrect)
            return
        }
        
        // Checks if the calculation has enought elements.
        guard expressionHaveEnoughElement else {
            errorDone(.expressionNotEnoughtLong)
            return
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
            
            //Realizes the calculation according to the operator.
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: fatalError("Unknown operator !")
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
    
    private enum ErrorType {
        case operandAlreadyChoosed, expressionNotCorrect, expressionNotEnoughtLong, divideByZero
    }
    
    /// Creates the right error notification according to the error situation.
    private func errorDone(_ errorType: ErrorType) {
        var errorName: String = ""
        switch errorType {
        case .expressionNotCorrect:
            errorName = "expressionNotCorrect"
        case .expressionNotEnoughtLong:
            errorName = "expressionNotEnoughtLong"
        case .operandAlreadyChoosed:
            errorName = "operandAlreadyChoosed"
        case .divideByZero:
            errorName = "divideByZero"
        }
        let errorNotificationName = Notification.Name(errorName)
        let errorNotification = Notification(name: errorNotificationName)
        NotificationCenter.default.post(errorNotification)
    }
    
    
}
