//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Dom W on 11/12/2019.
//  Copyright © 2019 Dom W. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Charts

protocol CanReceive {
    
    func dataReceived(data: String)
    
}


class QuizViewController: UIViewController {
    
    var delegate: CanReceive?
    
    let maxValue = 5
    
    let baseURL: String = "https://opentdb.com/api.php?"
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var questionCounter: Int = 0
    var currentQuestion: Question? = nil
    var numOfCorrect: Int = 0
    var numOfWrong: Int = 0
    
    var selectedSubject: Int = 0
    var questionsArr: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("I received")
        print(selectedSubject)
        
        let requestParams: [String: String] = [
            "type": "boolean",
            "amount": String(5),
            "category": String(selectedSubject)
        ]
        
        getQuizQuestions(requestUrl: baseURL, params: requestParams)
        
        setupPieChart()
        
    }
    
    
    
    func setupPieChart() {
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.rotationAngle = 0
        pieChartView.isUserInteractionEnabled = false
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: 0, label: "Wrong: \(0)"))
        entries.append(PieChartDataEntry(value: 0, label: "Correct: \(0)"))
        
        let dataSet = PieChartDataSet(values: entries, label: "")
        
        let c1 = NSUIColor(red: 250.0/255.0, green: 66.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        let c2 = NSUIColor(red: 111.0/255.0, green: 185.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        
        dataSet.colors = [c1, c2]
        
        dataSet.drawValuesEnabled = false
        
        pieChartView.data = PieChartData(dataSet: dataSet)
        
    
    }
    
    
    @IBAction func onAnswer(_ sender: UIButton) {
        
        if questionCounter == maxValue {
            questionLabel.text = "You answered all questions, press BACK to go to menu"
            return
        }
        
        if sender.titleLabel!.text == currentQuestion?.correct_answer {
            numOfCorrect = numOfCorrect + 1
        }
        else {
            numOfWrong = numOfWrong + 1
        }
        
        if sender.tag == 1 {
            
            var entries: [PieChartDataEntry] = Array()
            entries.append(PieChartDataEntry(value: Double(numOfWrong), label: "Wrong: \(numOfWrong)"))
            entries.append(PieChartDataEntry(value: Double(numOfCorrect), label: "Correct: \(numOfCorrect)"))
            
            let dataSet = PieChartDataSet(values: entries, label: "")
            
            let c1 = NSUIColor(red: 250.0/255.0, green: 66.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            let c2 = NSUIColor(red: 111.0/255.0, green: 185.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            
            dataSet.colors = [c1, c2]
            
            dataSet.drawValuesEnabled = false
            
            pieChartView.data = PieChartData(dataSet: dataSet)
            
        }
        if sender.tag == 2 {
            
            var entries: [PieChartDataEntry] = Array()
            entries.append(PieChartDataEntry(value: Double(numOfWrong), label: "Wrong: \(numOfWrong)"))
            entries.append(PieChartDataEntry(value: Double(numOfCorrect), label: "Correct: \(numOfCorrect)"))
            
            let dataSet = PieChartDataSet(values: entries, label: "")
            
            let c1 = NSUIColor(red: 250.0/255.0, green: 66.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            let c2 = NSUIColor(red: 111.0/255.0, green: 185.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            
            dataSet.colors = [c1, c2]
            
            dataSet.drawValuesEnabled = false
            
            pieChartView.data = PieChartData(dataSet: dataSet)
        }
        
        if questionCounter < maxValue - 1 {
            questionCounter = questionCounter + 1
            currentQuestion = questionsArr[questionCounter]
            questionLabel.text = currentQuestion?.question
            
        }
        else if questionCounter == maxValue - 1 {
            questionCounter = questionCounter + 1
            
        }
     
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        delegate?.dataReceived(data: "User pressed back !")
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Make API Request
    /******************************************************/
    func getQuizQuestions(requestUrl: String, params: [String: String]) {
        
        Alamofire.request(requestUrl, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess{
                print("Got quiz questions")
                
                let questionsJSON: JSON = JSON(response.result.value!)
                
                print(questionsJSON)
                
                self.parseQuestionsData(json: questionsJSON)
                
                self.currentQuestion = self.questionsArr[0]
                // print("IT is")
                // print(self.currentQuestion?.question)
                
                self.questionLabel.text = self.currentQuestion?.question
                
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
        
    }
    
    
    //MARK: - Parse JSON result
    /******************************************************/
    func parseQuestionsData(json: JSON) {
        
        let questionsArrJson = json["results"]
        for q in questionsArrJson {
            // print(q)
            let qo = q.1
            print(qo)
            let ques = qo["question"].string
            let corans = qo["correct_answer"].string
            let diff =  qo["difficulty"].string
            let singleQuestion = Question(question: ques!, correct_answer: corans!, difficulty: diff!)
            questionsArr.append(singleQuestion)
        }
        
        //print(questionsArr[0].question)
        // print(questionsArr[4].question)
        
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
