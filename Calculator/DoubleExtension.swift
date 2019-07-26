//
//  DoubleExtension.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation

extension Double {
    func toString(_ countAfterPoint: Int) -> String {
        let size = Double(truncating: pow(10, countAfterPoint) as NSNumber)
        return String((self * size).rounded() / size)
        
    }
}
