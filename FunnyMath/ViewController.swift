//
//  ViewController.swift
//  FunnyMath
//
//  Created by Tan on 1/3/18.
//  Copyright © 2018 Ngoc Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblTimeleft: UILabel!
    @IBOutlet weak var lblQuestionNumber: UILabel!
    @IBOutlet weak var lblQS: UILabel!
    @IBOutlet weak var lblQB: UILabel!
    @IBOutlet weak var lblQA: UILabel!
    @IBOutlet weak var btnAA: UIButton!
    @IBOutlet weak var btnAB: UIButton!
    @IBOutlet weak var btnAC: UIButton!
    @IBAction func btnAAClick(_ sender: Any) {
        guard let num = Int(lblTimeleft.text!), num < 11 else {
            timer?.invalidate()
            timer = nil
            return
        }
        if(currentRightAnswer == 1){
            point += 1
            currentRightAnswer = -1
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
            generateQA()
        }
        else{
            timer?.invalidate()
            timer = nil
            showDialogFailure(point: point)
        }
    }
    
    @IBAction func btnABClick(_ sender: Any) {
        guard let num = Int(lblTimeleft.text!), num < 11 else {
            timer?.invalidate()
            timer = nil
            return
        }
        if(currentRightAnswer == 2){
            point += 1
            currentRightAnswer = -1
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
            generateQA()
        }
        else{
            timer?.invalidate()
            timer = nil
            showDialogFailure(point: point)
        }
    }
    @IBAction func btnACClick(_ sender: Any) {
        guard let num = Int(lblTimeleft.text!), num < 11 else {
            timer?.invalidate()
            timer = nil
            return
        }
        if(currentRightAnswer == 3){
            point += 1
            currentRightAnswer = -1
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
            generateQA()
        }
        else{
            timer?.invalidate()
            timer = nil
            showDialogFailure(point: point)
        }
    }
    /*Idea:
         Using timer for random numberA, numberB, and operator
         Using random function for generate new number.
         Using random function for generate position of true answer and assign to button.
         After tap correct answer due to on time, move forward new question and do again.
         Tap wrong answer, alert dialog for displaying point and notify get failure
     
         Custom timer, start, release timer.
     */
    var timer:Timer?
    var currentRightAnswer:Int = -1
    var timeCount:Int = 0
    var point:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        generateQA()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func showDialogFailure(point : Int)  {
        let alert = UIAlertController(title: "Fail", message: "You got \(point * 10) points", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
    @objc func updateTimer(){
        timeCount += 1
        lblTimeleft.text = String(11 - timeCount);
        if (timeCount > 10){
            showDialogFailure(point: point)
            timer?.invalidate()
            timer = nil
            timeCount  = 0
            
        }
    }
   @objc func generateQA() {
        lblQuestionNumber.text = "Question: \(point)"
        timeCount = 0
        lblPoint.text = "Ps: \(String(point*10)) "
        //Random 0 -> 30 for each number
    let numA:Int = Int(arc4random_uniform(30))
    let numB:Int = Int(arc4random_uniform(30))
        //Random position for displaying position correct answer, 1 -> 3
        let correctPosition:Int = Int(arc4random_uniform(2))+1
        //Assign correct value to new variable
        let correctNum:Int = numA+numB
        //Random wrong answers
        let wrongNum1:Int = Int(arc4random_uniform(UInt32(Int32(correctNum-1)))) //Random from 0 -> correctNum-1
        let wrongNum2:Int = Int(arc4random_uniform(UInt32(Int32(correctNum*2)))) + (correctNum+1) //Random from correctNum+1 -> correctNum*2

        lblQA.text = "\(numA)"
        lblQB.text = "\(numB)"
        lblQS.text="+"
        //print(correctPosition , "\(correctNum)")
        switch correctPosition {
        case 1:
            btnAA.setTitle(String(correctNum), for: .normal)
            btnAB.setTitle(String(wrongNum1), for: .normal)
            btnAC.setTitle(String(wrongNum2), for: .normal)
            currentRightAnswer = 1
            break
        case 2:
            btnAB.setTitle(String(correctNum), for: .normal)
            btnAA.setTitle(String(wrongNum1), for: .normal)
            btnAC.setTitle(String(wrongNum2), for: .normal)
            currentRightAnswer = 2
            break
        case 3:
            btnAC.setTitle(String(correctNum), for: .normal)
             btnAA.setTitle(String(wrongNum2), for: .normal)
             btnAB.setTitle(String(wrongNum1), for: .normal)
            currentRightAnswer = 3
            break
        default:
            break
        }
        
    }

}

