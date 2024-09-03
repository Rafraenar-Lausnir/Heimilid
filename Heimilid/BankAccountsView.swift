//
//  BankAccountsView.swift
//  Heimilid
//
//  Created by Elín Ósk on 31.8.2024.
//

import SwiftUI

struct BankAccountsView: View {

  @Binding var bankAccounts: [BankAccount]

  var body: some View {
    VStack {
      Button {
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
      } label: {
        Btn(label: "Endurhlaða gögnum")
      }
      Divider()
      List {
        ForEach(bankAccounts) { bankAccount in
          NavigationLink {
            BankAccountDetailsView(bankAccount: bankAccount)
          } label: {
            HStack {
              VStack {
                Text(bankAccount.title)
                Text("\(bankAccount.number.description)")
              }
              Spacer()
              Text("\(bankAccount.status) kr.")
            }
          }
        }
      }
    }
  }
}

#Preview {
  BankAccountsView(bankAccounts: .constant([]))
}
