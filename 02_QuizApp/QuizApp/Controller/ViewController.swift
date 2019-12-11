//
//  ViewController.swift
//  QuizApp
//
//  Created by Dom W on 10/12/2019.
//  Copyright © 2019 Dom W. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var chosenSubject: Int = 0
    var labelText: String = ""
    
    let categoryValueMap: [String: Int] = [
        "Sports": 21,
        "Geography": 22,
        "Art": 25,
        "Animals": 27,
        "Politics": 24,
        "Celebrities": 26]
    
    @IBOutlet weak var chosenSubjectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onButtonPressed(_ sender: UIButton) {
        switch sender.tag {
            case 1:
                chosenSubject = categoryValueMap["Sports"]!
            case 2:
                chosenSubject = categoryValueMap["Geography"]!
            case 3:
                chosenSubject = categoryValueMap["Art"]!
            case 4:
                chosenSubject = categoryValueMap["Animals"]!
            case 5:
                chosenSubject = categoryValueMap["Politics"]!
            case 6:
                chosenSubject = categoryValueMap["Celebrities"]!
            default:
                chosenSubject = 25
        }
        print(chosenSubject)
        labelText = sender.titleLabel!.text!
        print(labelText)
        
        chosenSubjectLabel.text = labelText
        
    }
    
    
    @IBAction func onQuizStarted(_ sender: Any) {
        performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQuiz" {
            
            let destinationVC = segue.destination as! QuizViewController
            destinationVC.selectedSubject = chosenSubject
            
        }
        
    }
    
}

