//
//  ViewController.swift
//  Quiz
//
//  Created by Magic Keegan on 9/6/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionLable:UILabel!
    @IBOutlet var answerLable:UILabel!
    
    let questions : [String] = ["What is 7+7?","What is the capital of China","Who is the author"]
    let answers : [String] = ["14","Beijing","TastyHeadphones"]
    
    var currentIndex : Int = 0
    
    
    
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentIndex += 1
        if currentIndex == questions.count{
            currentIndex = 0
        }
        
        let question : String = questions[currentIndex]
        questionLable.text = question
        answerLable.text = "???"
        
        }
    
    @IBAction func showAnswer(_ sender: UIButton) {

        let answer : String = answers[currentIndex]
        answerLable.text = answer
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLable.text = questions[currentIndex]
    }
}

