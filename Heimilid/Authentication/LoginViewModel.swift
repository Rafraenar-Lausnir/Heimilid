//
//  LoginViewModel.swift
//  Admin
//
//  Created by Elín Ósk on 15.8.2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
  @Published var email: String = ""
  @Published var password: String = ""

  private var validationManager = ValidationManager.shared

  func login() async throws {
    guard validationManager.validateEmail(self.email),
          validationManager.validatePassword(self.password) else {
      throw MachError(.invalidArgument)
    }
    try await FirebaseAuthManager.shared
      .signIn(via: self.email, with: self.password)
  }
}
