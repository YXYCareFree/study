//
//  ViewController.swift
//  Calculator
//
//  Created by beyondSoft on 16/8/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var displayLabel: UILabel!

    var  operandStack = Array<Double>()

    var  userIsInTheMiddleOfTypingANumeber = false

    @IBAction func appendDigit(sender: UIButton) {

        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTypingANumeber {

            displayLabel.text = displayLabel.text! + digit
        }else{
            displayLabel.text = digit
            userIsInTheMiddleOfTypingANumeber = true
        }

    }

    @IBAction func operation(sender: UIButton) {
        let opration = sender.currentTitle!

        if userIsInTheMiddleOfTypingANumeber {
            enter()
        }
        switch opration {
        case "×":performOperate {$0 * $1}
        case "÷":performOperate {$1 / $0}
        case "+":performOperate {$0 + $1}
        case "−":performOperate {$1 - $0}
        default:
            break
        }
    }
    func performOperate(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation( operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumeber = false

        operandStack.append(displayValue)
        print(operandStack)
    }

    var displayValue: Double{
        get{
           return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set{
           displayLabel.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumeber = false
        }
    }


}

