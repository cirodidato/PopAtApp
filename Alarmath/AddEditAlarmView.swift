//
//  AddEditAlarmView.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 12/12/24.
//

import SwiftUI

struct AddEditAlarmView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTime: Date = Date()
    @State private var alarmLabel: String = "" // Nuova variabile per l'etichetta
    @Binding var alarms: [Alarm]
    
    @Environment(LocalNotificationManager.self) var notificationManager

    var body: some View {
        Form {
            // Selezione orario
            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
            
            // Campo di testo per l'etichetta
            TextField("Alarm Label", text: $alarmLabel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical)

            // Pulsante per salvare
            Button("Save") {
                saveAlarm()
                dismiss()
            }
        }
        .navigationTitle("Add Alarm")
    }

    private func saveAlarm() {
        // Logica per salvare la sveglia
        let newAlarm = Alarm(time: selectedTime, label: alarmLabel, isActive: true)
        alarms.append(newAlarm)
        
        Task {
            do {
                try await notificationManager.scheduleNotification(for: newAlarm)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    AddEditAlarmView(alarms: .constant([]))
}
