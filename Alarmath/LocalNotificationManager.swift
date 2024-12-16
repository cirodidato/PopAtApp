//
//  LocalNotificationManager.swift
//  Alarmath
//
//  Created by Ciro Di Dato on 16/12/24.
//

import Foundation
import UserNotifications

@MainActor
@Observable
class LocalNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    var notificationCenter = UNUserNotificationCenter.current()
    var currentAlarmID: String?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func requestAuthorization() async {
        do {
            try await notificationCenter.requestAuthorization()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func scheduleNotification(for alarm: Alarm) async throws {
        let content = UNMutableNotificationContent()
        content.title = alarm.label.isEmpty ? "Sveglia" : alarm.label // Usa l'etichetta se esiste
        content.body = "È ora di svegliarsi!"
        content.sound = UNNotificationSound.defaultCritical
        content.userInfo = ["alarmID": alarm.id.uuidString]

        // Configura l'orario
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        // Crea la richiesta
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Aggiungi la notifica
        try await UNUserNotificationCenter.current().add(request)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        guard let alarmID = response.notification.request.content.userInfo["alarmID"] as? String else { return }
        currentAlarmID = alarmID
    }
}
