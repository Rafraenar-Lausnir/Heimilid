//
//  BankAccountsView.swift
//  Heimilid
//
//  Created by Elín Ósk on 31.8.2024.
//

import SwiftUI

struct BankAccountsView: View {

  var body: some View {
    VStack {
      Button {
        Task {
          do {
            try await TmpData.shared.loadBankAccounts()
          } catch let err {
            print("Error fetching bank accounts: \(err.localizedDescription)")
          }
        }
      } label: {
        Btn(label: "Endurhlaða gögnum")
      }
      Divider()
      List {
        ForEach(TmpData.shared.bankAccounts) { bankAccount in
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
  BankAccountsView()
}
