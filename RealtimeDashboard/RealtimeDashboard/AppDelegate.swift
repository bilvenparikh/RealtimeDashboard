//
//  AppDelegate.swift
//  RealtimeDashboard
//
//  Created by Bilven Parikh on 01/04/24.
//

import UIKit
import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        return true
    }
}
