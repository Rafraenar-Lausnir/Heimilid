//
//  FirebaseAuthManager.swift
//  Admin
//
//  Created by Elín Ósk on 15.8.2024.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthManager {
  static let shared = FirebaseAuthManager()
  private let auth = Auth.auth()

  private init() {
    self.auth.languageCode = "is"
  }

  private func reauthenticateUser(with credential: AuthCredential) async throws -> User {
    guard let user = fetchSignedInUser() else {
      throw URLError(.unknown)
    }
    return try await user.reauthenticate(with: credential).user
  }

  @discardableResult
  func fetchSignedInUser() -> User? {
    let user = auth.currentUser
    if let user = user {
      let usr = Usr(user)
      TmpData.shared.user = usr
    }
    return auth.currentUser
  }

  func signIn(via email: String, with password: String) async throws {
    let authDataResult = try await auth.signIn(withEmail: email, password: password)

    let user = try await FirebaseFirestoreManager.shared
      .fetchUser(for: authDataResult.user.uid)

    print("Fetched Database user: \(user.uid)")

    TmpData.shared.user = user
  }

  func createUser(for email: String) async throws {
    var randPassword: String = ""

    let passChar = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
    for _ in 0..<8 {
        // generate a random index based on your array of characters count
      let rand = arc4random_uniform(UInt32(passChar.count))
        // append the random character to your string
      randPassword.append(passChar[Int(rand)])
    }

    let authDataResult = try await auth.createUser(
      withEmail: email,
      password: randPassword
    )

    try FirebaseFirestoreManager.shared.createNewUser(for: Usr(authDataResult.user))
  }

  func reauthenticateUser(via email: String, with password: String) async throws -> AuthCredential {
    let authDataResult = try await auth.signIn(
      withEmail: email,
      password: password
    )
    if let credential = authDataResult.credential {
      return credential
    } else {
      throw URLError(.unknown)
    }
  }

  func signOut() throws {
    try auth.signOut()
    TmpData.shared.user = nil
  }

  func resetPassword(_ credential: AuthCredential, to newPassword: String) async throws {
    let user = try await self.reauthenticateUser(with: credential)
    try await user.updatePassword(to: newPassword)
  }

  func updateEmail(_ credential: AuthCredential, to newEmail: String) async throws {
    let user = try await self.reauthenticateUser(with: credential)
    try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
  }

  func sendEmailVerification(_ credential: AuthCredential) async throws {
    let user = try await self.reauthenticateUser(with: credential)
    try await user.sendEmailVerification()
  }
}
