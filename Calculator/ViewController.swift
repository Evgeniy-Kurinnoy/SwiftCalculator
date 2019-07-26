//
//  ViewController.swift
//  Calculator
//
//  Created by Евгений Куринной on 6/16/19.
//  Copyright © 2019 Evgeniy Kurinnoy. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var outputField: UITextField!
    
    private var calculator = Calculator()
    private var disposable: Disposable?

    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.inputView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    override func viewDidAppear(_ animated: Bool) {
        disposable = calculator.rx.subscribe {
            switch $0 {
            case .next(let result, let error):
                if let err = error {
                    //self.outputField.text = "unsupported format"
                    print(err)
                } else {
                    self.outputField.text = result.toString(8)
                }
            default:
                break
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disposable?.dispose()
    }
    @IBAction func pressSymbolButton(_ sender: UIButton) {
        guard let currentString = inputField.text else { return }
        let cursorPosition = inputField.selectedRange.location
        let indexOfPosition = currentString.index(currentString.startIndex, offsetBy: cursorPosition)
        let insertedString = sender.title(for: .normal)!
        
        inputField.text?.insert(contentsOf: insertedString, at: indexOfPosition)
        inputField.selectedRange = NSRange(location: cursorPosition + insertedString.count, length: 0)
        performAction(sender)
    }
    
    @IBAction func clearAllButton(_ sender: Any) {
        outputField.text = ""
        inputField.text = ""
    }
    
    @IBAction func removeAction(_ sender: Any) {
        guard let currentString = inputField.text else { return }
        let cursorPosition = inputField.selectedRange.location
        if cursorPosition == 0 { return }
        let indexOfPosition = currentString.index(currentString.startIndex, offsetBy: cursorPosition - 1)
        inputField.text.remove(at: indexOfPosition)
        inputField.selectedRange = NSRange(location: cursorPosition - 1, length: 0)
        performAction(sender)
    }
    
    @IBAction func performAction(_ sender: Any) {
        calculator.push(inputField.text)
    }
    
}
