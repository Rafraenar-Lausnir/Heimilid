//
//  LoginView.swift
//  Admin
//
//  Created by Elín Ósk on 15.8.2024.
//

import SwiftUI

struct LoginView: View {

  @StateObject private var vm = LoginViewModel()
  @Binding var isLoggedIn: Bool

  var body: some View {
    VStack {
      Image("Logo_Icon")
        .resizable()
        .frame(width: 150, height: 150)
      Text("Heimilið")
        .font(.title)
        .foregroundStyle(Color("text_color"))
      Text("Auðveldari heimilisrekstur!")
        .font(.headline)
        .foregroundStyle(Color("text_color"))

      Spacer()
      
      TextField("Netfang", text: $vm.email)
        .padding()
        .background(Color("text_color"))
        .foregroundStyle(Color("bg_color"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .keyboardType(.emailAddress)
        .textContentType(.emailAddress)
        .textInputAutocapitalization(.never)
      SecureField("Lykilorð", text: $vm.password)
        .padding()
        .background(Color("text_color"))
        .foregroundStyle(Color("bg_color"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .keyboardType(.default)
        .textContentType(.password)
        .textInputAutocapitalization(.never)

      Spacer()

      Button {
        Task {
          do {
            try await vm.login()
            isLoggedIn = true
          } catch let err {
            print("Error logging in: \(err)")
            try? FirebaseAuthManager.shared.signOut()
          }
        }
      } label: {
        Btn(label: "Skrá inn")
      }

    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      Color("bg_color")
    )
  }
}

#Preview {
  LoginView(isLoggedIn: .constant(false))
}
