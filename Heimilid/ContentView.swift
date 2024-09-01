//
//  ContentView.swift
//  Heimilid
//
//  Created by Elín Ósk on 26.8.2024.
//

import SwiftUI

struct ContentView: View {

  @Binding var isLoggedIn: Bool
  @State private var title: String = ""
  @State private var number: String = ""
  @State private var type: BankAccount.AccountType = .checking
  @State private var bankAccounts: [BankAccount] = []

  var body: some View {
    NavigationStack {
      VStack {
          // For testing purposes only - can be removed

        NavigationLink {
          BankAccountsView(bankAccounts: $bankAccounts)
        } label: {
          Text("Bankareikningar")
        }


        TextField("Heiti", text: $title)
          .padding()
          .background(Color("text_color"))
          .foregroundStyle(Color("bg_color"))
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .keyboardType(.default)
          .textInputAutocapitalization(.sentences)

        TextField("Númer reiknings", text: $number)
          .padding()
          .background(Color("text_color"))
          .foregroundStyle(Color("bg_color"))
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .keyboardType(.numberPad)

        Picker("Tegund", selection: $type) {
          Text(BankAccount.AccountType.checking.rawValue)
            .tag(BankAccount.AccountType.checking)
          Text(BankAccount.AccountType.savings.rawValue)
            .tag(BankAccount.AccountType.savings)
          Text(BankAccount.AccountType.investing.rawValue)
            .tag(BankAccount.AccountType.investing)
        }

        Button {
          do {
            guard let newAccountNumber = Int(self.number), let user = FirebaseAuthManager.shared.fetchSignedInUser() else {
              throw URLError(.unknown)
            }
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let id = String((0..<64).map{ _ in letters.randomElement()! })
            let newAccount = BankAccount(
              id: id,
              title: self.title,
              number: newAccountNumber,
              status: 0,
              goal: 0,
              type: self.type
            )
            try FirebaseFirestoreManager.shared
              .createNewAccount(newAccount, for: user.uid)
          } catch let err {
            print("Error creating bank account: \(err.localizedDescription)")
          }
        } label: {
          Btn(label: "Stofna reikning")
        }
        Divider()
        Button {
          do {
            try FirebaseAuthManager.shared.signOut()
            isLoggedIn = false
          } catch let err {
            print("Error logging out: \(err.localizedDescription)")
          }
        } label: {
          Btn(label: "Skrá út")
        }
      }
    }
    .padding()
    .onAppear {
      Task {
        guard let user = FirebaseAuthManager.shared.fetchSignedInUser() else {
          print("Error fetching current user!")
          return
        }
        guard let bankAccounts = try? await FirebaseFirestoreManager.shared.fetchAccounts(for: user.uid) else {
          print("Error fetching bank accounts")
          return
        }
        self.bankAccounts = bankAccounts
      }
    }
  }
}

#Preview {
  ContentView(isLoggedIn: .constant(true))
}
