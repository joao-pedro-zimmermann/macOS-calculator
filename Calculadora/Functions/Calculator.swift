//
//  Calculator.swift
//  Calculadora
//
//  Created by João Pedro Zimmermann on 03/01/24.
//

import Foundation

struct Calculator {
    
    static func evaluateExpression(expression: [String]) -> String {
        
        if expression.count < 3 {
            return ""
        }
        
        if isOperator(op: expression[expression.count - 1]) {
            return ""
        }
        
        
        let result = solveOperations(expression: expression)
        
        return floatToString(float: result)
    }
    
    static func solveOperations(expression: [String]) -> Float {
        var aux_expression = expression
        var ctrl = aux_expression.firstIndex(of: "÷") ?? -1
        
        if aux_expression.count > 2 {
            while ctrl > 0 {
                aux_expression[ctrl] = floatToString(float: executeOperation(
                    num1: stringToFloat(str: aux_expression[ctrl - 1]),
                    num2: stringToFloat(str: aux_expression[ctrl + 1]),
                    operation: aux_expression[ctrl]))
                
                aux_expression.remove(at: ctrl - 1)
                aux_expression.remove(at: ctrl)
                
                ctrl = aux_expression.firstIndex(of: "÷") ?? -1
            }
        }
        
        if aux_expression.count == 1 {
            return stringToFloat(str: aux_expression[0])
        }
        
        ctrl = aux_expression.firstIndex(of: "×") ?? -1
        
        if aux_expression.count > 2 {
            while ctrl > 0 {
                aux_expression[ctrl] = floatToString(float: executeOperation(
                    num1: stringToFloat(str: aux_expression[ctrl - 1]),
                    num2: stringToFloat(str: aux_expression[ctrl + 1]),
                    operation: aux_expression[ctrl]))
                
                aux_expression.remove(at: ctrl - 1)
                aux_expression.remove(at: ctrl)
                
                ctrl = aux_expression.firstIndex(of: "×") ?? -1
            }
        }
        
        if aux_expression.count == 1 {
            return stringToFloat(str: aux_expression[0])
        }
        
        ctrl = 1
        var resul: Float = stringToFloat(str: aux_expression[0])
        
        while ctrl < aux_expression.count - 1 {
            
            resul = executeOperation(
                                    num1: resul,
                                    num2: stringToFloat(str: aux_expression[ctrl + 1]),
                                    operation: aux_expression[ctrl]
                                )
            ctrl = ctrl + 2
        }
        
        return resul
    }
        
    static func floatToString(float: Float) -> String {
        return String(float)
    }
    
    static func stringToFloat(str: String) -> Float {
        return Float(str) ?? 0
    }
    
    static func isOperator(op: String) -> Bool {
        if (op == "+" || op == "×" || op == "-" || op == "÷") {
            return true
        } else {
            return false
        }
    }
    
    static func isNumber(num: String) -> Bool {
        if Float(num) != nil {
            return true
        } else {
            return false
        }
    }
    
    static func executeOperation(num1: Float, num2: Float, operation: String) -> Float {
        
        switch operation {
            case "+":
                return num1 + num2
            case "-":
                return num1 - num2
            case "÷":
                return num1 / num2
            case "×":
                return num1 * num2
            default:
                return 0
        }
    }
    
    static func countOpenParenthesisInExpression(expression: [String]) -> Int {
        return expression.filter{$0 == "("}.count
    }
    
    static func countClosedParenthesisInExpression(expression: [String]) -> Int {
        return expression.filter{$0 == ")"}.count
    }
    
    static func isParenthesis(cell: String) -> Bool {
        if cell == "(" || cell == ")" {
            return true
        } else {
            return false
        }
    }
    
    static func isOpenParenthesis(cell: String) -> Bool {
        if cell == "(" {
            return true
        } else {
            return false
        }
    }
    
}
