//
//  Numbers.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation

let numbers: [Number.Type] = [Double.self, Pi.self, Exp.self]

extension Double: Number {
    var number: Double {
        return self
    }
    
    var string: String {
        return String(self)
    }
    
    static func from(_ string: String) -> Number? {
        return Double(string)
    }
}

class Pi: Number {
    var number: Double = Double.pi
    var string: String = "π"
    
    static func from(_ string: String) -> Number? {
        let pi = Pi()
        if string == pi.string {
            return pi
        } else {
            return nil
        }
    }
}

class Exp: Number {
    var number: Double = exp(1)
    
    static func from(_ string: String) -> Number? {
        let exp = Exp()
        if string == exp.string {
            return exp
        } else {
            return nil
        }
    }
    
    var string: String = "e"
    
    
}
