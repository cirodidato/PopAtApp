//
//  AlarmTriggerView.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 12/12/24.
//

import SwiftUI

struct AlarmTriggerView: View {
    let alarm: Alarm
    @Environment(\.dismiss) var dismiss
    
    var question = Question.all.randomElement()!
    @State private var userInput = ""
    
    var body: some View {
        VStack {
            Text("è ora della pappa!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Spacer()
            
            Text("Per disattivare la sveglia, rispondi alla seguente domanda:")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            Text(question.question)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            TextField("Scrivi qui...", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none) // Evita la capitalizzazione automatica
                .disableAutocorrection(true)
            
            Spacer()
            
            Button {
                if userInput == question.answer {
                    dismiss()
                }
            } label: {
                Text("Fatto!")
                    .font(.title2)
                    .padding()
                    .background(userInput == question.answer ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(userInput != question.answer) // Disabilita il pulsante finché l'input non è corretto
            .padding(.bottom)
        }
        .padding()
    }
}

// Anteprima per AlarmTriggerView
struct AlarmTriggerView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmTriggerView(alarm: Alarm(time: .now, label: "Ciao", isActive: true))
    }
}
