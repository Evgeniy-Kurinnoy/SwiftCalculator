//
//  ExpressionElement.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation

enum ExpressionElement {
    case operation(Operation)
    case number(Number)
    
    var string: String {
        switch self {
        case .operation(let operation):
            return operation.string
        case .number(let number):
            return number.string
        }
    }
    
    var number: Number? {
        switch self {
        case .number(let number):
            return number
        case .operation(_):
            return nil
        }
    }
    
    var operation: Operation? {
        switch self {
        case .number(_):
            return nil
        case .operation(let operation):
            return operation
        }
    }
}
