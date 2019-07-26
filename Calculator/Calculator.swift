//
//  Calculator.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/16/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import Foundation
import RxSwift

typealias CalculateResult = (result: Double, error: Error?)
class IllegalFormatError: Error {}

class Calculator {
    public var rx: Observable<CalculateResult> {
        return observable
            .map { Calculator.calculate($0) }
            .asObservable()
            .subscribeOn(OperationQueueScheduler(operationQueue: .main))
            .observeOn(MainScheduler.instance)
    }
    private let observable = PublishSubject<String>()
    
    func push(_ string: ExpressionString) {
        observable.on(.next(string))
    }
    
    static func calculate(_ string: ExpressionString)->CalculateResult {
        let result = Expression(from: string)?.result()
        
        if let res = result {
            return (result: res, error: nil)
        } else {
            return (result: 0.0, error: IllegalFormatError())
        }
    }
}

