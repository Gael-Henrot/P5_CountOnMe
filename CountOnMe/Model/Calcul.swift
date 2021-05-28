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
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveResult: Bool {
        return elementsToDisplay.firstIndex(of: "=") != nil
    }
    
    func addANumber(_ numberSelected: String) {
        
        if expressionHaveResult {
            elementsToDisplay = ""
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
            return
        } else {
            errorDone(.operandAlreadyChoosed)
            return
        }
    }

    func calculate() {
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
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        elementsToDisplay.append(" = \(operationsToReduce.first!)")
    }
    
    enum ErrorType {
        case operandAlreadyChoosed, expressionNotCorrect, expressionNotEnoughtLong
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
        }
        let errorNotificationName = Notification.Name(errorName)
        let errorNotification = Notification(name: errorNotificationName)
        NotificationCenter.default.post(errorNotification)
    }
    
    
}
