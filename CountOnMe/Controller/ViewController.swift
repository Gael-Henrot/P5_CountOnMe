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
    
    ///This method displays the elements of calculation in the textView.
    ///It is used each time a number or an operand is added to the calculation.
    ///It also scrolls to the bottom if the calculation is too long.
    private func display() {
        textView.text = calcul.elementsToDisplay
        
        // Scrolls to the bottom
        let range = NSMakeRange((textView.text as NSString).length - 1, 1);
        textView.scrollRangeToVisible(range)
    }
    
//==============================================================
// MARK: Tapped Buttons
// All methods call the corresponding method in Calcul class.
// It displays the good Error AlertController according to the possible error.
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calcul.addANumber(numberText)
        display()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        do {
            try calcul.addAPlus()
            display()
        } catch Calcul.ErrorType.operandAlreadyChoosed {
            operandAlreadyChoosedError()
        } catch {
            
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        do {
            try calcul.addAMinus()
            display()
        } catch Calcul.ErrorType.operandAlreadyChoosed {
            operandAlreadyChoosedError()
        } catch {
            
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        do {
            try calcul.calculate()
            display()
        } catch Calcul.ErrorType.expressionNotCorrect {
            expressionNotCorrectError()
        } catch Calcul.ErrorType.expressionNotEnoughtLong {
            expressionNotEnoughtLongError()
        } catch Calcul.ErrorType.divideByZero {
            divideByZeroError()
        } catch Calcul.ErrorType.unknownOperator {
            unknownOperatorError()
        } catch {
            
        }
        
    }
    
    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        do {
            try calcul.addAMultiply()
            display()
        } catch Calcul.ErrorType.operandAlreadyChoosed {
            operandAlreadyChoosedError()
        } catch {
            
        }
    }
    
    @IBAction func tappedDivideButton(_ sender: UIButton) {
        do {
            try calcul.addADivide()
            display()
        } catch Calcul.ErrorType.operandAlreadyChoosed {
            operandAlreadyChoosedError()
        } catch {
            
        }
    }
    
    @IBAction func tappedEraseButton (_sender: UIButton) {
        do {
            try calcul.delete()
            display()
        } catch Calcul.ErrorType.expressionNotEnoughtLong {
            expressionNotEnoughtLongError()
        } catch {
            
        }
    }
    
    @IBAction func tappedPointButton (_ sender: UIButton) {
        do {
            try calcul.addAPoint()
            display()
        } catch Calcul.ErrorType.cantAddAPoint {
            cantAddAPointError()
        } catch {
            
        }
    }

//==============================================================
// MARK: Error AlertControllers
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func operandAlreadyChoosedError() {
        showError(title: "Nope!", message: "Un opérateur est déjà sélectionné !")
    }
    
    func expressionNotCorrectError() {
        showError(title: "Nope!", message: "Entrez une expression correcte !")
    }
    
    func expressionNotEnoughtLongError() {
        showError(title: "Go!", message: "Démarrez un nouveau calcul !")
    }
    
    func divideByZeroError() {
        showError(title: "Zéro!", message: "Division par zéro impossible !")
    }
    
    func unknownOperatorError() {
        showError(title: "Nope!", message: "Opérateur inconnu !")
    }
    
    func cantAddAPointError() {
        showError(title: "Nope!", message: "Impossible d'ajouter une virgule!")
    }
}

