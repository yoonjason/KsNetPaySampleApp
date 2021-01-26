//
//  AppDelegate.swift
//  KsNetPaySampleApp
//
//  Created by twave on 2021/01/25.
//

import UIKit
import CoreData
import UserNotifications
import Firebase
import CoreTelephony
import AdSupport
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()

        Messaging.messaging().delegate = self

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        getDeviceInfo()
        
        return true
    }
    
    func getDeviceInfo(){
        let locale = Locale.current.regionCode
        var idfa : String = ""
        let manager = ASIdentifierManager.shared()
        guard manager.isAdvertisingTrackingEnabled else {
            return
        }
        idfa = manager.advertisingIdentifier.uuidString
        #if targetEnvironment(simulator)
        idfa = "A8F03200-4DCF-42FE-B5F6-EE6D3471C702"
        #endif
        
//        Globals.sharedInstance.initParameters["uuid1"] = idfa
//        Globals.sharedInstance.headers["uuid"] = idfa
        
        if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            Globals.sharedInstance.initParameters["uuid"] = idfv
            Globals.sharedInstance.uuid = idfv
        }
        let systemVersion = UIDevice.current.systemVersion
        if let appVersionInfo = Globals.sharedInstance.appVersionInfo {
            Globals.sharedInstance.headers["app-Version"] = appVersionInfo
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let telephoneInfo = CTTelephonyNetworkInfo()
        var operatorName : String = "testPhone"
        if let provider = telephoneInfo.serviceSubscriberCellularProviders?.first?.value {
            if let carrierName = provider.carrierName {
                operatorName = carrierName
            }
        }
        Globals.sharedInstance.initParameters["osVer"] = systemVersion
        Globals.sharedInstance.initParameters["operator"] = operatorName
        Globals.sharedInstance.initParameters["brand"] = "apple"
        Globals.sharedInstance.initParameters["model"] = identifier
        
        
        let jsonToData = ["os_ver_int":"", "os_ver":systemVersion, "operator":operatorName, "brand":"apple", "model":identifier]
        
        
//        if let jsonStr = Functions.convertIntoJSONString(arrayObject: jsonToData) {
//            Globals.sharedInstance.initParameters["deviceInfo"] = jsonStr
//        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "KsNetPaySampleApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {


        print("Firebase registration token : \(fcmToken)")
        Globals.sharedInstance.pushToken = fcmToken ?? ""
        print("Globals push token is \(Globals.sharedInstance.pushToken)")
        Globals.sharedInstance.initParameters["fcmToken"] = fcmToken
        Globals.sharedInstance.initfff()
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)

    }


    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print("\(#function) #####::::#####  \(userInfo)")
        print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print("\(#function) #####::::#####  \(userInfo)")

        completionHandler(UIBackgroundFetchResult.newData)
    }
    

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = notification.request.content.userInfo
//        print("\(#function) #####::::#####  \(userInfo)")
        
        print("푸시 메시지 클릭시 클릭 이벤트가 전달되는 함수인가요?")
        print(response.notification.request.content.userInfo)
        let data = response.notification.request.content.userInfo
        NotificationCenter.default.post(name: Notification.Name("pushData"), object: nil, userInfo: data)
        completionHandler()
    }

    //foreground에 있을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        guard let messageId = userInfo[gcmMessageIDKey] else {
            print("\(#function), no message")
            return
        }
        center.delegate = self

        print("\(#function) ::: \(userInfo)")
        NotificationCenter.default.post(name: Notification.Name("pushData"), object: nil, userInfo: userInfo)
        completionHandler([.badge, .banner])
    }


}

extension NSNotification {
    static let token = NSNotification.Name.init("TOKEN")
}
