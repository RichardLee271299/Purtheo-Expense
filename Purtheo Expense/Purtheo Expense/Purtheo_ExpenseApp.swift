//
//  Purtheo_ExpenseApp.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 16/03/2023.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
  }
}

@main
struct Purtheo_ExpenseApp: App {
 
    @StateObject var appstate: AppState = AppState.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appstate)
                .preferredColorScheme(.light)
        }
        
    }
}
