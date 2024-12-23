//
//  AlarmRowView.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 16/12/24.
//

import SwiftUI

struct AlarmRowView: View {
    @Binding var alarm: Alarm
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $alarm.isActive) {
                HStack {
                    Text(alarm.label)
                    
                    Text(alarm.time.formatted(date: .omitted, time: .shortened))
                }
            }

            Text("Mission")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    @Previewable @State var alarm = Alarm(time: .now, label: "Poppata 1", isActive: false)
    
    AlarmRowView(alarm: $alarm)
}
