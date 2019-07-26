//
//  ArrayExtensions.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation


extension Array where Element == ExpressionElement {
    
    func getMaxPriorityOperationIndex()->Int?{
        let priorities = self.map { el -> Int in
            switch el {
            case .operation(let operation):
                return operation.priority
            case .number(_):
                return -1
            }
        }
        
        guard let index = priorities.indexOfMax else { return nil }
        
        if priorities[index] == -1 {
            return nil
        } else {
            return index
        }
    }
    
}

extension Array where Element == Operation {
    func from(string: String)->Operation?{
        for operation in self {
            if operation.string == string {
                return operation
            }
        }
        return nil
    }
}

extension Array where Element == Number.Type {
    func from(string: String)->Number?{
        for number in self {
            if let num = number.from(string) {
                return num
            }
        }
        return nil
    }
}

extension Array where Element: Comparable {
    var indexOfMax: Index? {
        guard var maxValue = self.first else { return nil }
        var maxIndex = 0
        for (index, value) in self.enumerated() {
            if value > maxValue {
                maxValue = value
                maxIndex = index
            }
        }
        return maxIndex
        
    }
}
