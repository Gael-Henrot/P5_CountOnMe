//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calcul = Calcul()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calcul.addANumber(numberText)
        textView.text = calcul.elementsToDisplay
        
        /*guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)*/
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        guard calcul.addAPlus() == nil else {
            showError(messageChoice: .operandAlreadyChoosed)
            return
        }
        textView.text = calcul.elementsToDisplay
        /*if canAddOperator {
            textView.text.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }*/
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        guard calcul.addAMinus() == nil else {
            showError(messageChoice: .operandAlreadyChoosed)
            return
        }
        textView.text = calcul.elementsToDisplay
        /*if canAddOperator {
            textView.text.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }*/
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calcul.calculate() == nil else {
            showError(messageChoice: .expressionNotCorrect)
            return
        }
        textView.text = calcul.elementsToDisplay
        /*guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
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
        textView.text.append(" = \(operationsToReduce.first!)")*/
    }
    
    enum MessageType {
        case operandAlreadyChoosed, expressionNotCorrect, expressionNotEnoughtLong
    }
    
    private func showError(messageChoice: MessageType) {
        
        let message: String?
        
        switch messageChoice {
        case .operandAlreadyChoosed:
            message = "Un operateur est déja mis !"
        case .expressionNotCorrect:
            message = "Entrez une expression correcte !"
        case .expressionNotEnoughtLong:
            message = "Démarrez un nouveau calcul !"
        }
        
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

}
