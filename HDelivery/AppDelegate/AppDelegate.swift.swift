//
//  AppDelegate.swift.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

import Firebase
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            print("Notification permission: \(granted)")
        }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let fcmToken = fcmToken, !fcmToken.isEmpty else {
            print("FCM token is nil")
            return
        }
        
        do {
            
            
            
            try StorageManager.shared.storeFCMToken(fcmToken)
        }
        catch {
           print(error.localizedDescription)
            
        }
       
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      print("------------------------Notification Data---Start----------------------")
       print(notification.request.content.userInfo)
        print("------------------------Notification Data---END----------------------")
        completionHandler([.banner, .sound])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Tapped notification: \(userInfo)")
        completionHandler()
    }

}
