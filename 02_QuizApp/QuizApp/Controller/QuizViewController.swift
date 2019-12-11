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
import PieCharts

class QuizViewController: UIViewController {
    
    let baseURL: String = "https://opentdb.com/api.php?"
    
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
        
        print(questionsArr[0].question)
         print(questionsArr[4].question)
        
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
