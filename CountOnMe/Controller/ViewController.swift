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
        // Notifications for errors
        let errorExpressionNotCorrectName = Notification.Name("expressionNotCorrect")
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorExpressionNotCorrect), name: errorExpressionNotCorrectName, object: nil)
        let errorExpressionNotEnoughtLongName = Notification.Name("expressionNotEnoughtLong")
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorExpressionNotEnoughtLong), name: errorExpressionNotEnoughtLongName, object: nil)
        let errorOperandAlreadyChoosedName = Notification.Name("operandAlreadyChoosed")
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorOperandAlreadyChoosed), name: errorOperandAlreadyChoosedName, object: nil)
        let errorDivideByZeroName = Notification.Name("divideByZero")
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorDivideByZero), name: errorDivideByZeroName, object: nil)
    }
    
    ///This method displays the elements of calculation in the textView.
    ///It is used each time a number or an operand is added to the calculation.
    ///It also scrolls to the bottom if the calculation is too long.
    private func display() {
        textView.text = calcul.elementsToDisplay
        
        // Scrolls to the bottom
        let range = NSMakeRange((textView.text as NSString).length - 1, 1);
        textView.scrollRangeToVisible(range)
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calcul.addANumber(numberText)
        display()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calcul.addAPlus()
        display()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calcul.addAMinus()
        display()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calcul.calculate()
        display()
    }
    
    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        calcul.addAMultiply()
        display()
    }
    
    @IBAction func tappedDivideButton(_ sender: UIButton) {
        calcul.addADivide()
        display()
    }
    
    @IBAction func tappedEraseButton (_sender: UIButton) {
        calcul.delete()
        display()
    }
    
    @IBAction func tappedPointButton (_ sender: UIButton) {
        calcul.addAPoint()
        display()
    }
    
    ///This method shows an alert when an expression is not correct (expression ends with an operand).
    @objc private func showErrorExpressionNotCorrect() {
        let alertVC = UIAlertController(title: "Nope!", message: "Entrez une expression correcte !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    ///This method shows an alert when an expression is not long enought (3 elements minimum).
    @objc private func showErrorExpressionNotEnoughtLong() {
        let alertVC = UIAlertController(title: "Allez!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    ///This method shows an alert when an operand is already choosed.
    @objc private func showErrorOperandAlreadyChoosed() {
        let alertVC = UIAlertController(title: "Nope!", message: "Un operateur est déjà mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    ///This method shows an alert when the user try to divide by 0.
    @objc private func showErrorDivideByZero() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Division par zéro impossible !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

