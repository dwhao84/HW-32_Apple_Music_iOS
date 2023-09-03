//
//  AppDelegate.swift
//  HW#32_AppleMusic_iOS
//
//  Created by Dawei Hao on 2023/8/6.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Adjust the UITabBarItem when Tab Bar is selected.
           UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.systemPink], for: .selected)

        // Adjust the UITabBarItem when Tab Bar unselected.
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        
        // Custom tabBar appearance for tintColor
        UITabBar.appearance().tintColor = .systemPink

        // Playing music when the app is in the background.
        try? AVAudioSession.sharedInstance().setCategory(.playback)

        // Playing music on an iPhone while it's on the lock screen.
        application.beginReceivingRemoteControlEvents()

        return true
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


}

