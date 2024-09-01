//
//  BankAccountDetailsView.swift
//  Heimilid
//
//  Created by Elín Ósk on 1.9.2024.
//

import SwiftUI

struct BankAccountDetailsView: View {

  var bankAccount: BankAccount
  @State private var addNewTransactionSheet: Bool = false

  var body: some View {
    VStack {
      Text(bankAccount.title)
      Text("\(bankAccount.number)")
      Text("Staða: \(bankAccount.status)")
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          addNewTransactionSheet.toggle()
        } label: {
          Image(systemName: "plus.circle.fill")
        }

      }
    }
    .sheet(isPresented: $addNewTransactionSheet) {
      Text("Bæta við færslu")
    }
  }
}

#Preview {
  BankAccountDetailsView(
    bankAccount: BankAccount(id: "", title: "", number: 123456, status: 123456, goal: 154532, type: .checking)
  )
}
