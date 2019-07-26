//
//  Protocols.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation

protocol PresentExpressionElement {
    var string: String { get }
}

protocol Operation: PresentExpressionElement {
    var priority: Int { get }
    func perform(lhs: Number?, rhs: Number?) -> Number?
    
}

protocol Number: PresentExpressionElement {
    var number: Double { get }
    static func from(_ string: String) -> Number?
}
