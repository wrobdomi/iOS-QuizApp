//
//  Question.swift
//  QuizApp
//
//  Created by Dom W on 11/12/2019.
//  Copyright © 2019 Dom W. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let correct_answer: String
    let difficulty: String
    
    init(question: String, correct_answer: String, difficulty: String) {
        self.question = question
        self.correct_answer = correct_answer
        self.difficulty = difficulty
    }
    
}
