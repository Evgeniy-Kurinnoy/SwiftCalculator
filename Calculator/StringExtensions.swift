//
//  StringExtensions.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/17/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation

extension String {
    func split(by separators: [String])->[String.SubSequence]{
        if separators.isEmpty {
            return [self.prefix(self.count)]
        }
        var result: String?
        for separator in separators {
            guard let res = result else {
                result = self.replacingOccurrences(of: separator, with: "\n\(separator)\n")
                continue
            }
            result = res.replacingOccurrences(of: separator, with: "\n\(separator)\n")
        }
        return result!.split(separator: "\n")
    }
}
