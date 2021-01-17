//
//  OurCoinSimpleApp.swift
//  OurCoinSimple
//
//  Created by Kitty Guz on 12/10/20.
//

import SwiftUI
import Firebase

@main
struct OurCoinSimpleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
        }
    }
}
