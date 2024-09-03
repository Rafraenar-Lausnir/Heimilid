//
//  BankAccountTransaction.swift
//  Heimilid
//
//  Created by Elín Ósk on 2.9.2024.
//

import Foundation

struct BankAccountTransaction: Codable, Identifiable {

  enum TransactionType: String, Codable {
    case transfer = "Millifærsla"
    case saving = "Sparnaður"
    case investment = "Fjárfesting"
  }

  let id: String
  let date: Date
  let title: String
  let account: BankAccount
  let amount: Int
  let goal: Int
  let type: TransactionType

  init(
    id: String,
    date: Date,
    title: String,
    account: BankAccount,
    amount: Int,
    goal: Int,
    type: TransactionType
  ) {
    self.id = id
    self.date = date
    self.title = title
    self.account = account
    self.amount = amount
    self.goal = goal
    self.type = type
  }
}
