//
//  HeimilidApp.swift
//  Heimilid
//
//  Created by Elín Ósk on 26.8.2024.
//

import SwiftUI
import Firebase

@main
struct HeimilidApp: App {

  @State private var isLoggedIn: Bool

  init() {
    FirebaseApp.configure()
    FirebaseAuthManager.shared.fetchSignedInUser()
    if TmpData.shared.user != nil {
      self.isLoggedIn = true
    } else {
      self.isLoggedIn = false
    }
  }

  var body: some Scene {
    WindowGroup {
      ContentView(isLoggedIn: $isLoggedIn)
//      if isLoggedIn {
//        ContentView(isLoggedIn: $isLoggedIn)
//      } else {
//        LoginView(isLoggedIn: $isLoggedIn)
//      }
    }
  }
}
