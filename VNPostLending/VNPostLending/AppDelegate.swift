//
//  AppDelegate.swift
//  VNPostLending
//
//  Created by Nguyen Thanh Bình on 6/15/19.
//  Copyright © 2019 Nguyen Thanh Bình. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftEntryKit
import Realm
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var timer: Timer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { (_) in
            let realm = try? Realm(configuration: realmConfig)
            guard let obj = realm?.objects(LoanObject.self) else { return }
            if obj.count > 0 {
                var attrs = EKAttributes()
                attrs.position = EKAttributes.Position.center
                attrs.displayDuration = 5
                attrs.positionConstraints = EKAttributes.PositionConstraints.init(verticalOffset: 0.0, size: EKAttributes.PositionConstraints.Size(width: .offset(value: 30.0), height: .constant(value: 300)), maxSize: EKAttributes.PositionConstraints.Size(width: .offset(value: 30.0), height: .constant(value: 300)))
                attrs.screenBackground = .color(color: UIColor(hexString: "000000", transparency: 0.4)!)
                attrs.roundCorners = .all(radius: 10.0)
                attrs.entryInteraction = .absorbTouches
                attrs.screenInteraction = .dismiss
                let vc = storyboard.instantiateViewController(withClass: LoanRemindViewController.self)
                vc?.loan = obj.first!
                SwiftEntryKit.display(entry: vc!, using: attrs)
            }
        })
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

