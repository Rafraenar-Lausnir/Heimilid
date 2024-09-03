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
  @State private var newTransactionType: BankAccountTransaction.TransactionType = .transfer
  @State private var amount: String = ""
  @State private var date: Date = Date()

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
      VStack {
        DatePicker(
          "Dagsetning færslu",
          selection: $date,
          displayedComponents: .date
        )
        Picker("Tegund", selection: $newTransactionType) {
          Text(BankAccountTransaction.TransactionType.transfer.rawValue)
            .tag(BankAccountTransaction.TransactionType.transfer)
          Text(BankAccountTransaction.TransactionType.saving.rawValue)
            .tag(BankAccountTransaction.TransactionType.saving)
          Text(BankAccountTransaction.TransactionType.investment.rawValue)
            .tag(BankAccountTransaction.TransactionType.investment)
        }
        if newTransactionType == .transfer {
        TextField("Upphæð", text: $amount)
          .padding()
          .background(Color("text_color"))
          .foregroundStyle(Color("bg_color"))
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .keyboardType(.numbersAndPunctuation)
          Button {
            Task {
              do {
                guard let amountNumber = Int(self.amount), let user = FirebaseAuthManager.shared.fetchSignedInUser() else {
                  throw URLError(.unknown)
                }
                let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                let id = String((0..<64).map{ _ in letters.randomElement()! })
                let newTransaction = BankAccountTransaction(
                  id: id,
                  date: date,
                  title: "",
                  account: bankAccount,
                  amount: amountNumber,
                  goal: 0,
                  type: newTransactionType
                )
                try await FirebaseFirestoreManager.shared
                  .createTransaction(newTransaction, for: user.uid)
                addNewTransactionSheet.toggle()
              } catch let err {
                print("Error creating bank account: \(err.localizedDescription)")
              }
            }
          } label: {
            Btn(label: "Stofna færslu")
          }
        }
      }
    }
  }
}

#Preview {
  BankAccountDetailsView(
    bankAccount: BankAccount(id: "", title: "", number: 123456, status: 123456, goal: 154532, type: .checking)
  )
}
