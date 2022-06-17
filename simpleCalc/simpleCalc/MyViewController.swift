//
//  MyViewController.swift
//  simpleCalc
//
//  Created by Darko Skerlevski on 14.6.22.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = "";
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var btnOne: UIButton!

    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnEquals: UIButton!
    
    var prevNum : Float = 0
    var secondNumber : Bool = false
    var pressedSign : String = "+"
    
    fileprivate func doOneOfTheOperations(sign : String) {
        if secondNumber {
            if let tmp = Float(textField.text!) {
                switch pressedSign {
                case "+":
                    prevNum += tmp
                case "-":
                    prevNum -= tmp
                case "x":
                    prevNum *= tmp
                case "/":
                    prevNum /= tmp
                default:
                    print("no sign found")
                }
                
                textField.text = ""
            }
        }
        else {
            if let tmp = Float(textField.text!) {
                prevNum = tmp
                secondNumber = true
                textField.text = ""
            }
            
        }
        pressedSign = String(sign)
        print(prevNum)
    }
    
    fileprivate func doSingleOperation(_ tmp: Float, sign: String) -> Float {
        switch sign {
        case "+":
            return prevNum + tmp
        case "-":
            return prevNum - tmp
        case "x":
            return prevNum * tmp
        default:
            return prevNum / tmp
        }
    }
    
    @IBAction func buttonTouched(_ sender: Any) {
        if let touchedButton: UIButton = sender as? UIButton {
//            print(touchedButton.title(for: .normal)!)
            if textField.text == "Error" {
                textField.text = ""
            }
            switch touchedButton.title(for: .normal){
            case "0":
                textField.text = textField.text! + "0"
            case "1":
                textField.text = textField.text! + "1"
            case "2":
                textField.text = textField.text! + "2"
            case "3":
                textField.text = textField.text! + "3"
            case "4":
                textField.text = textField.text! + "4"
            case "5":
                textField.text = textField.text! + "5"
            case "6":
                textField.text = textField.text! + "6"
            case "7":
                textField.text = textField.text! + "7"
            case "8":
                textField.text = textField.text! + "8"
            case "9":
                textField.text = textField.text! + "9"
            case "AC":
                textField.text = ""
                secondNumber = false
                prevNum = 0
                pressedSign = "+"
            case "x!":
                if var number = Int(textField.text!){
                    var tmpText: Int = 1
                    while (number>0) {
                        if case let (_, overflow) = tmpText.multipliedReportingOverflow(by: number), !overflow {
                            if case let (_, overflow1) = tmpText.addingReportingOverflow(tmpText), !overflow1 {
                                tmpText = tmpText * number
                                number = number - 1
                            }
                            else {
                                textField.text = String("Error")
                                break
                            }
                        }
                        else {
                            textField.text = String("Error")
                            break
                        }
                            
                        
                    }
                    textField.text = String(tmpText)
                }
                else {
                    textField.text = "Error"
                }
            case ".":
                textField.text = textField.text! + "."
            case "+", "-", "x", "/":
                doOneOfTheOperations(sign: touchedButton.title(for: .normal)!)
            case "=":
                if let tmp = Float(textField.text!) {
                    let sum = doSingleOperation(tmp, sign: pressedSign)
                    if (floor(sum) == sum) {
                        textField.text = String(Int(sum))
                    }
                    else {
                        textField.text = String(sum)
                    }
                    secondNumber = false
                    
                }
            case "+/-":
                var input = Array(textField.text!)
                if (!input.isEmpty) {
                    if input[0] == "-" {
                        input[0] = "+"
                        textField.text = String(input)
                    }
                    else if input[0] == "+" {
                        input[0] = "-"
                        textField.text = String(input)
                    }
                    else {
                        textField.text = "-" + String(input)
                    }
                }
            case "%":
                if let validNumber = Float(textField.text!) {
                    textField.text = String(validNumber/100)
                }
            default:
                print("lmao")
                
            }
        }
        else {
            print("No button")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
