//
//  QuestionsManager.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 16/12/24.
//

import Foundation

struct Question: Identifiable {
    var id = UUID()
    var question: String
    var answer: String
    
    static var all = [Question(question: "Soprannome", answer: "Nina"), Question(question: "Cognome madre", answer: "Russo"), Question(question: "Cibo preferito", answer: "Latte")] 
}
