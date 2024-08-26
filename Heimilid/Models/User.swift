//
//  User.swift
//  Admin
//
//  Created by Elín Ósk on 17.8.2024.
//

import Foundation
import FirebaseAuth

struct Usr: Codable {
  let uid: String
  let email: String?
  let photoUrl: String?
  let dateCreated: Date?
  let dateUpdated: Date?
  let isAdmin: Bool

  init(_ user: User) {
    self.uid = user.uid
    self.email = user.email
    self.photoUrl = user.photoURL?.absoluteString
    self.dateCreated = Date()
    self.dateUpdated = Date()
    self.isAdmin = false
  }
}
