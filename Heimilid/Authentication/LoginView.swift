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
  @State private var isLoading: Bool = false

  var body: some View {
    VStack {
      header
      Spacer()
      inputField("Netfang", labelImage: "envelope", text: $vm.email)
      inputField("Lykilorð", labelImage: "lock", text: $vm.password, isSecureField: true)
      Spacer()
      loginButton
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      Color("bg_color")
    )
  }
}

extension LoginView {
  var header: some View {
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
    }
  }

  var loginButton: some View {
    Button("Skrá inn") {
      isLoading.toggle()
      Task {
        do {
          try await vm.login()
          isLoading.toggle()
          isLoggedIn = true
        } catch let err {
          print("Error logging in: \(err)")
          try? FirebaseAuthManager.shared.signOut()
          isLoading.toggle()
        }
      }
    }
    .loading(isLoading)
    .buttonStyle(.main)

//    Button {
//      Task {
//        do {
//          try await vm.login()
//          isLoggedIn = true
//        } catch let err {
//          print("Error logging in: \(err)")
//          try? FirebaseAuthManager.shared.signOut()
//        }
//      }
//    } label: {
//      Btn(label: "Skrá inn")
//      Text("Skrá inn")
//        .frame(maxWidth: .infinity)
//    }
//    .buttonStyle(.bordered)
//    .controlSize(.large)
//    .padding(30)
  }

  func inputField(_ labelTitle: String, labelImage: String, text: Binding<String>, isSecureField: Bool = false) -> some View {
    VStack(alignment: .leading) {
      Text(labelTitle).font(.callout).foregroundStyle(Color("text_color"))
      HStack {
        Image(systemName: labelImage)
        if isSecureField {
          SecureField(labelTitle, text: text)
        } else {
          TextField(labelTitle, text: text)
        }
      }.underlineTextField()
    }.padding()
  }
}

#Preview {
  LoginView(isLoggedIn: .constant(false))
}
