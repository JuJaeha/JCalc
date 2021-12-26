//
//  ViewController.swift
//  JCalc
//
//  Created by JAEHA JU on 2021/10/29.
//

import UIKit
import CalcCore

class ViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var currentNumberLabel: UILabel!
    
    //숫자 초기화를 막기 위해서 사용하는 변수 : 1누르고 2누르면 12가 나와야함
    var currentNumber: Double = 0.0 { didSet { updateUI() }}
    var currentOperator: CalcOperator? { didSet { updateUI() }}
    var currentOperation: CalcOperation = CalcOperation() { didSet { updateUI() }}
    var recordArray: [String] = []
    
    func updateUI() {
        currentNumberLabel.text = currentNumber.truncatingRemainder(dividingBy: 1.0) == 0.0 ? String(Int64(currentNumber)) : String(currentNumber)
        operationLabel.text = currentOperation.operationString()
        if let op = currentOperator {
            operationLabel.text = operationLabel.text! + " " + op.symbol
        }
        if currentNumber != 0.0 {
            clearButton.setTitle("C", for: .normal)
        } else {
            clearButton.setTitle("AC", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        if currentNumber != 0.0 {
            currentNumber = 0.0
        } else {
            currentOperation = CalcOperation()
        }
    }
    
    @IBAction func plusMinusTapped(_ sender: UIButton) {
        currentNumber = currentNumber * (-1)
    }
    
    @IBAction func percentButtonTapped(_ sender: UIButton) {
        if currentNumber != 0.0 {
            currentNumber = currentNumber / 100
        }
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        addOperationNode()
        //초기화를 .plus로 진행 나중에 변경 필요.
        var currentOp: CalcOperator = .plus
        switch sender.tag{
            case 101:
                currentOp = .div
            case 102:
                currentOp = .mult
            case 103:
                currentOp = .minus
            case 104:
                currentOp = .plus
            default :
            ()
        }
        currentOperator = currentOp
    }
    
    func addOperationNode() {
        guard currentNumber != 0.0 else { return }
        
        if let currentOp = currentOperator {
            currentOperation.operationNodes.append(CalcOperationNode(op: currentOp, operand: currentNumber))
        } else {
            currentOperation.baseNumber = currentNumber
        }
        currentOperator = nil
        currentNumber = 0
    }
    @IBAction func numberPadTapped(_ sender: UIButton) {
        //tag를 50으로 설정 : 1번의 tag는 51, 2번의 tag는 52 ...
        //->예외적인 상황이 발생할 수 있어서 만듦
        let buttonNumber = sender.tag - 50
        currentNumber = currentNumber * 10 + Double(buttonNumber)
    }
    @IBAction func showResult(_ sender: UIButton) {
        addOperationNode()
        
        operationLabel.text = operationLabel.text! + " " + "=" + " " + String(currentOperation.calcResult())

        currentNumberLabel.text = String(currentOperation.calcResult())
    }
    @IBAction func deleteNumber(_ sender: UIButton) {
        guard currentNumber != 0 else{
            return
        }
        
        let lastNumber = currentNumber.truncatingRemainder(dividingBy: 10)
        currentNumber = ( currentNumber - lastNumber ) / 10
    }
    
    
}

