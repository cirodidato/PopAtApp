//
//  ContentView.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 12/12/24.
//

import SwiftUI

struct HomeView: View {
    @State private var alarms: [Alarm] = [] // Lista delle sveglie
    @State private var isEditing: Bool = false // Modalità modifica
    @Environment(LocalNotificationManager.self) var notificationManager: LocalNotificationManager

    var body: some View {
        @Bindable var notificationManager = notificationManager
        
        NavigationView {
            VStack {
                if alarms.isEmpty {
                    Text("No alarms set")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach($alarms) { $alarm in
                            AlarmRowView(alarm: $alarm)
                        }
                        .onDelete(perform: deleteAlarm)
                    }
                }
            }
            .navigationTitle("Poppate")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddEditAlarmView(alarms: $alarms)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .fullScreenCover(item: $notificationManager.currentAlarmID) { id in
            if let alarm = alarms.first(where: { $0.id.uuidString == id }) {
                AlarmTriggerView(alarm: alarm)
            }
        }
    }

    private func deleteAlarm(at offsets: IndexSet) {
        alarms.remove(atOffsets: offsets)
    }
}


#Preview {
    HomeView()
        .environment(LocalNotificationManager())
}
