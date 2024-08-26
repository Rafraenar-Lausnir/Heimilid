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

  init() {
    FirebaseApp.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
