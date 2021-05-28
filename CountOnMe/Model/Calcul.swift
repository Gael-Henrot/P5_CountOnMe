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
    
    func addAPlus() -> ErrorType? {
        if canAddOperator {
            elementsToDisplay.append(" + ")
            return nil
        } else {
            return .operandAlreadyChoosed
            /*let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)*/
        }
    }
    
    func addAMinus() -> ErrorType? {
        if canAddOperator {
            elementsToDisplay.append(" - ")
            return nil
        } else {
            return .operandAlreadyChoosed
            /*let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)*/
        }
    }

    func calculate() -> ErrorType? {
        guard expressionIsCorrect else {
            return .expressionNotCorrect
            /*let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)*/
        }
        
        guard expressionHaveEnoughElement else {
            return .expressionNotCorrect
            /*let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)*/
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
        return nil
    }
    
    enum ErrorType {
        case operandAlreadyChoosed, expressionNotCorrect, expressionNotEnoughtLong
    }
}
