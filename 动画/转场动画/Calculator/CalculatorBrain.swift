
//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by beyondSoft on 16/8/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

import Foundation

class CalulatorBrain {

    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }

    var  opStack = [Op]()

    var knowOps = [String: Op]()

    init() {

        //knowOps["×"] = Op.BinaryOperation("×"){$0 * $1}
        knowOps["×"] = Op.BinaryOperation("×", *)
        //knowOps["+"] = Op.BinaryOperation("+"){$0 + $1}
        knowOps["+"] = Op.BinaryOperation("+", +)
        knowOps["−"] = Op.BinaryOperation("−"){$1 - $0}
        knowOps["÷"] = Op.BinaryOperation("÷"){$1 / $0}
    }


    func pushOperand(operand: Double) {

        opStack.append(Op.Operand(operand))
    }

    func performOperation(symbol: String) {

        if let operation = knowOps[symbol] {
            opStack.append(operation)
        }


    }
}