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
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
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
    
    // MARK: Add something to the calculation methods
    
    func addANumber(_ numberSelected: String) {
        
        if expressionHaveResult {
            elementsToDisplay = ""
        }
        
        guard !(elementsToDisplay.contains(" / ") && numberSelected == "0") else {
            errorDone(.divideByZero)
            return
        }
        
        elementsToDisplay.append(numberSelected)
    }
    
    func addAPlus() {
        if canAddOperator {
            elementsToDisplay.append(" + ")
        } else {
            errorDone(.operandAlreadyChoosed)
        }
    }
    
    func addAMinus() {
        if canAddOperator {
            elementsToDisplay.append(" - ")
        } else {
            errorDone(.operandAlreadyChoosed)
        }
    }
    
    func addAMultiply() {
        if canAddOperator {
            elementsToDisplay.append(" x ")
        } else {
            errorDone(.operandAlreadyChoosed)
        }
    }
    
    func addADivide() {
        if canAddOperator {
            elementsToDisplay.append(" / ")
        } else {
            errorDone(.operandAlreadyChoosed)
        }
    }
    
    func calculate() {
        guard expressionHaveResult == false else {
            errorDone(.expressionNotCorrect)
            return
        }
        
        guard expressionIsCorrect else {
            errorDone(.expressionNotCorrect)
            return
        }
        
        guard expressionHaveEnoughElement else {
            errorDone(.expressionNotEnoughtLong)
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var i = 1
            
            if expressionHaveAMultiply {
                i = (operationsToReduce.firstIndex(of: "x") ?? 1)
            }
            if expressionHaveADivide {
                i = (operationsToReduce.firstIndex(of: "/") ?? 1)
            }
            
            let rangeToRemove = i-1...i+1
            let left = Double(operationsToReduce[i-1])!
            let operand = operationsToReduce[i]
            let right = Double(operationsToReduce[i+1])!
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            case "=": result = left
            default: fatalError("Unknown operator !")
            }
            operationsToReduce.removeSubrange(rangeToRemove)
            operationsToReduce.insert("\(result)", at: i-1)
//            operationsToReduce = Array(operationsToReduce.dropFirst(3))
//            operationsToReduce.insert("\(result)", at: 0)
        }
        elementsToDisplay.append(" = \(operationsToReduce.first!)")
    }
    
    enum ErrorType {
        case operandAlreadyChoosed, expressionNotCorrect, expressionNotEnoughtLong, divideByZero
    }
    
    func errorDone(_ errorType: ErrorType) {
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
