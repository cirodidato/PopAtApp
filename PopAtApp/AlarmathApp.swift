//
//  AlarmathApp.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 12/12/24.
//

import SwiftUI

extension String: Identifiable {
    public var id: Self { self }
}

@main
struct AlarmathApp: App {
    @State private var notificationManager = LocalNotificationManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .task {
                    await notificationManager.requestAuthorization()
                }
                .environment(notificationManager)
        }
    }
}
