//
//  BankAccounts.swift
//  Heimilid
//
//  Created by Elín Ósk on 31.8.2024.
//

import Foundation

struct BankAccount: Codable, Identifiable {

  enum AccountType: String, Codable {
    case checking = "Tékkareikningur"
    case savings = "Sparnaðarreikningur"
    case investing = "Fjárfestingareikningur"
  }

  let id: String
  let firestoreID: String?
  let title: String
  let number: Int
  let status: Int
  let goal: Int
  let type: AccountType

  init(
    id: String,
    firestoreID: String? = nil,
    title: String,
    number: Int,
    status: Int,
    goal: Int,
    type: AccountType
  ) {
    self.id = id
    self.firestoreID = firestoreID
    self.title = title
    self.number = number
    self.status = status
    self.goal = goal
    self.type = type
  }
}
