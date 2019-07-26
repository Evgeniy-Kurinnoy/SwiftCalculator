//
//  Operations.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation

let operations: [Operation] = [Add(), Multiply(), Logarithm(), Minus(), Divide(), Sinus(), Factorial(), Pow(), Cosinus(), Sqrt()]

class Add: Operation {
    var priority: Int = 1
    
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        guard let left = lhs, let right = rhs else {
            return nil
        }
        return left.number + right.number
    }
    
    var string: String {
        return "+"
    }
}

class Minus: Operation {
    var priority: Int = 1
    
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        if let left = lhs,
            let right = rhs {
            return left.number - right.number
        } else if let right = rhs {
            return -right.number
        } else {
            return nil
        }
    }
    
    var string: String = "-"
    
    
}

class Multiply: Operation {
    var priority: Int = 2
    
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        guard let left = lhs, let right = rhs else {
            return nil
        }
        return left.number * right.number
    }
    
    var string: String {
        return "*"
    }
}

class Divide: Operation {
    var priority: Int = 2
    
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        guard let left = lhs, let right = rhs else {
            return nil
        }
        return left.number / right.number
    }
    
    var string: String = "/"
    
    
}

class Pow: Operation {
    var priority: Int = 3
    
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        guard let left = lhs, let right = rhs else {
            return nil
        }
        return pow(left.number, right.number)
        
    }
    
    var string: String = "^"
}

class Logarithm: Operation {
    var priority: Int = 10
    
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        if let left = lhs, let right = rhs {
            return logC(val: right.number, forBase: left.number)
        } else if let right = rhs {
            return logC(val: right.number, forBase: Exp().number)
        } else {
            return nil
        }
    }
    
    var string: String {
        return "log"
    }
    
    func logC(val: Double, forBase base: Double) -> Double {
        return log(val)/log(base)
    }
}

class Factorial: Operation {
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        guard let left = lhs else {
            return nil
        }
        return Factorial.factorial(left.number)
    }
    
    var priority: Int = 10
    
    var string: String = "!"
    
    static func factorial(_ factorialNumber: Double) -> Double {
        if factorialNumber == 0 {
            return 1
        } else {
            return factorialNumber * factorial(factorialNumber - 1)
        }
    }
}

class Sinus: Operation {
    func perform(lhs:Number?, rhs: Number?) -> Number? {
        guard let right = rhs else {
            return nil
        }
        return sin(right.number)
    }
    
    var priority: Int = 10
    
    var string: String = "sin"
}


class Cosinus: Operation {
    func perform(lhs:Number?, rhs: Number?) -> Number? {
        guard let right = rhs else {
            return nil
        }
        return cos(right.number)
    }
    
    var priority: Int = 10
    
    var string: String = "cos"
}

class Sqrt: Operation {
    var priority: Int = 3
    var string: String = "√"
    
    func perform(lhs: Number?, rhs: Number?) -> Number? {
        if let left = lhs, let right = rhs {
            return pow(right.number, 1.0 / left.number)
        } else if let right = rhs {
            return sqrt(right.number)
        } else {
            return nil
        }
    }
    
}
