//
//  BankAccounts.swift
//  Heimilid
//
//  Created by Elín Ósk on 31.8.2024.
//

import Foundation

struct BankAccount: Codable {

  enum AccountType: Codable {
    case checking, savings, investing
  }

  let id: String
  let title: String
  let number: Int
  let status: Int
  let goal: Int
  let type: AccountType

  init(
    id: String,
    title: String,
    number: Int,
    status: Int,
    goal: Int,
    type: AccountType
  ) {
    self.id = id
    self.title = title
    self.number = number
    self.status = status
    self.goal = goal
    self.type = type
  }
}
