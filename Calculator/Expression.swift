//
//  Expression.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation

typealias ExpressionString = String

class Expression: Number {
    private var expression: [ExpressionElement]
    
    init?(_ expression: [ExpressionElement]) {
        if !Expression.isValid(expression: expression) {
            return nil
        }
        self.expression = expression
    }
    
    init?(from string: ExpressionString){
        let string = string
        print("init with:", string)
        if string.isEmpty {
            return nil
        }
        
        let splitByBracket = string.split(by: [")", "("]).map { String($0) }
        print("split by bracket:", splitByBracket)
        var result: [Any] = []
        
        // replace subExpression
        var openBracketIndex: Int?
        var bracketCount = 0
        
        for (index, item) in splitByBracket.enumerated() {
            if item == "(" {
                if openBracketIndex == nil {
                    openBracketIndex = index
                } else {
                    bracketCount += 1
                }
            } else if item == ")" {
                bracketCount -= 1
                if bracketCount <= 0 {
                    bracketCount -= 1
                    let openBracket = openBracketIndex ?? 0
                    let subExpressionString = splitByBracket[(openBracket+1)...(index-1)].joined()
                    let expression = Expression(from: subExpressionString)
                    guard let exp = expression else { return nil }
                    result.append(exp)
                    openBracketIndex = nil
                }
            } else if openBracketIndex == nil {
                result.append(item)
            }
        }
        print("result after replace subExpressions", result)
        
        // split by operations
        result = result.map { any in
            if let string = any as? String {
                return string.split(by: operations.map { $0.string } ).map { String($0) }
            } else {
                return [any]
            }
            }.reduce([], +)
        print("result after split", result)
        
        // replace operations and simple numbers
        result = result.map { element in
            if let string = element as? String {
                if let operation = operations.from(string: string) {
                    return operation
                } else if let double = numbers.from(string: string){
                    return double
                } else {
                    return string
                }
            } else {
                return element
            }
        }
        
        // to ExpressionElement array
        guard let expression = result.map ({ any -> ExpressionElement? in
            if let operation = any as? Operation {
                return .operation(operation)
            } else if let number = any as? Number {
                return .number(number)
            } else {
                return nil
            }
        }) as? [ExpressionElement] else {
            return nil
        }
        
        if !Expression.isValid(expression: expression){
            return nil
        }
        print("result expression", expression)
        self.expression = expression
    }
    
    func result()->Double{
        var performedExpression = self.expression
        while true {
            let operationIndex = performedExpression.getMaxPriorityOperationIndex()
            guard let index = operationIndex else { break }
            let operation = performedExpression[index].operation!
            let rhsIndex = index + 1
            let lhsIndex = index - 1
            
            let leftValue: Number?
            let rightValue: Number?
            
            if rhsIndex >= performedExpression.count {
                rightValue = nil
            } else {
                rightValue = performedExpression[rhsIndex].number
            }
            
            if lhsIndex < 0 {
                leftValue = nil
            } else {
                leftValue = performedExpression[lhsIndex].number
            }
            
            let removedLeftIndex: Int
            let removedRightIndex: Int
            
            if leftValue == nil {
                removedLeftIndex = index
            } else {
                removedLeftIndex = index - 1
            }
            
            if rightValue == nil {
                removedRightIndex = index
            } else {
                removedRightIndex = index + 1
            }
            
            let resultValue = operation.perform(lhs: leftValue, rhs: rightValue)
            if let value = resultValue ?? leftValue ?? rightValue {
                performedExpression.removeSubrange(removedLeftIndex..<(removedRightIndex + 1))
                performedExpression.insert(.number(value), at: removedLeftIndex)
            } else {
                performedExpression.removeSubrange(removedLeftIndex..<(removedRightIndex + 1))
            }
            
        }
        
        return performedExpression.first?.number?.number ?? 0.0
    }
    
    var string: String {
        return "(" + expression.map {
            $0.string
            }.joined(separator: "") + ")"
    }
    
    var number: Double {
        return result()
    }
    
    static func from(_ string: String) -> Number? {
        return Expression(from: string)
    }
    
    private static func isValid(expression: [ExpressionElement]) -> Bool {
        //        if expression.isEmpty {
        //            return false
        //        }
        //
        //        if expression.first is Operation || expression.last is Operation {
        //            return false
        //        }
        //
        //        var prevElement: ExpressionElement?
        //        for element in expression {
        //            if type(of: element) == type(of: prevElement){
        //                return false
        //            }
        //            prevElement = element
        //        }
        return true
    }
}
