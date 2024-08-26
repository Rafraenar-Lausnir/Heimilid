//
//  ContentView.swift
//  Heimilid
//
//  Created by Elín Ósk on 26.8.2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
// For testing purposes only - can be removed
      Button {
        do {
          try FirebaseAuthManager.shared.signOut()
//          isLoggedIn = false
        } catch let err {
          print("Error logging out: \(err.localizedDescription)")
        }
      } label: {
        Btn(label: "Skrá út")
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
