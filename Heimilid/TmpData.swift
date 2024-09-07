//
//  TmpData.swift
//  Heimilid
//
//  Created by Elín Ósk on 3.9.2024.
//

import Foundation

final class TmpData {
  static let shared = TmpData()
  private init() {}

  var user: Usr? = nil
  var bankAccounts: [BankAccount] = []

  func loadBankAccounts() async throws {
    guard let user = user else {
      throw URLError(.unknown)
    }
    try await FirebaseFirestoreManager.shared.fetchAccounts(for: user.uid)
  }
}
