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

  @State private var isLoggedIn: Bool = false

  init() {
    FirebaseApp.configure()
    if FirebaseAuthManager.shared.fetchSignedInUser() != nil {
      self.isLoggedIn = true
    }
  }

  var body: some Scene {
    WindowGroup {
      if isLoggedIn {
        ContentView(isLoggedIn: $isLoggedIn)
      } else {
        LoginView(isLoggedIn: $isLoggedIn)
      }
    }
  }
}
