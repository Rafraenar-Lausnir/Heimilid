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
    List {
      ForEach(bankAccounts) { bankAccount in
        NavigationLink {
          Text(bankAccount.title)
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

#Preview {
  BankAccountsView(bankAccounts: .constant([]))
}
