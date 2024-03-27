//
//  ContentView.swift
//  Calculadora
//
//  Created by João Pedro Zimmermann on 03/01/24.
//

import SwiftUI

struct ContentView: View {
    
    let grid = [
        ["C", "()", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["", "0", ".", "="]
    ]
    
    @State var result: String = "0"
    @State var expression: [String] = []
    @State var displayExpression: String = ""
    @State var textSize = CGSize(width: 200, height: 100)
    @State private var frameWidth: CGFloat = 175
    @State private var frameHeight: CGFloat = 175
    let layout = [
        GridItem(.fixed(50), spacing: 0),
        GridItem(.fixed(50), spacing: 0),
        GridItem(.fixed(50), spacing: 0),
        GridItem(.fixed(50), spacing: 0)
    ]
    
    var body: some View {
        
        Grid(alignment: .center, verticalSpacing: 5) {
                    GridRow{
                        Text("\(displayExpression)")
                            .font(.system(size: 300))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)

                    }
                    .frame(width: 150, height: 50)
                
                    GridRow {
                        Text("\(result)")
                            .font(.system(size: 300))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                    }
                    .frame(width: 150, height: 50)
                
                GridRow {
                    
                    
                    LazyVGrid(columns: layout, spacing: 0) {
                       ForEach(grid, id: \.self) { row in
                           ForEach(row, id: \.self) { cell in
                               Rectangle()
                                   .overlay(
                                        Text("\(cell)")
                                            .foregroundColor(.white)
                                   )
                                   .foregroundColor(.red)
                                   .frame(height: 40)
                                   .onTapGesture {
                                       handleButtonPress(cell: cell)
                                   }
                                   .border(Color.black)
                                   
                           }
                       }
                   }
                    .frame(width: 200, height: 200)
                }
            }
        .background(Color.black)
    }
    
    func handleButtonPress(cell: String) {
        print(expression)
        
        switch cell {
        case "C":
            cleanResult()
            cleanExpression()
            cleanDisplay()
        case "=":
            cleanExpression()
            appendToExpression(cell: result)
            cleanDisplay()
            concatenateCellToExpressionString(cell: result)
            result = ""
        case "()":
            handleParenthesisPress()
        default:
            appendToExpression(cell: cell)
            concatenateCellToExpressionString(cell: cell)
            result = Calculator.evaluateExpression(expression: expression)
        }
        print(expression)
    }
    
    func handleParenthesisPress() {
        print(Calculator.countOpenParenthesisInExpression(expression: expression))
        print(Calculator.countClosedParenthesisInExpression(expression: expression))
        if expression.count == 0 {
            appendToExpression(cell: "(")
            concatenateCellToExpressionString(cell: "(")
        } else {
            if Calculator.isOperator(op: expression[expression.count - 1]) {
                appendToExpression(cell: "(")
                concatenateCellToExpressionString(cell: "(")
            } else {
                if Calculator.countOpenParenthesisInExpression(expression: expression) - Calculator.countClosedParenthesisInExpression(expression: expression) > 0 {
                    if Calculator.isOpenParenthesis(cell: expression[expression.count - 1]) {
                        appendToExpression(cell: "(")
                        concatenateCellToExpressionString(cell: "(")
                    } else {
                        appendToExpression(cell: ")")
                        concatenateCellToExpressionString(cell: ")")
                    }
                } else {
                    appendToExpression(cell: "×")
                    concatenateCellToExpressionString(cell: "×")
                    appendToExpression(cell: "(")
                    concatenateCellToExpressionString(cell: "(")
                }
            }
        }
    }
    
    func appendToExpression(cell: String) {
        if expression.count == 0 {
            expression.append(cell)
        } else {
            if Calculator.isOperator(op: cell) {
                expression.append(cell)
            } else {
                if Calculator.isParenthesis(cell: cell) {
                    expression.append(cell)
                } else {
                    if Calculator.isOperator(op: expression[expression.count - 1]) {
                        expression.append(cell)
                    } else {
                        if Calculator.isParenthesis(cell: expression[expression.count - 1]) {
                            expression.append(cell)
                        } else {
                            expression[expression.count - 1] = expression[expression.count - 1] + cell
                        }
                    }
                }
                
            }
        }
    }
    
    func concatenateCellToExpressionString(cell: String) {
        displayExpression = displayExpression + cell
    }
    
    func cleanResult() {
        result = "0"
    }
    
    func cleanExpression() {
        expression = []
    }
    
    func cleanDisplay() {
        displayExpression = ""
    }
}

#Preview {
    ContentView()
}
