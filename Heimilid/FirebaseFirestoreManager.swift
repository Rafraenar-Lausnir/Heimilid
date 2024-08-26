//
//  FirebaseFirestoreManager.swift
//  Admin
//
//  Created by Elín Ósk on 17.8.2024.
//

import Foundation
import FirebaseFirestore

final class FirebaseFirestoreManager {
  static let shared = FirebaseFirestoreManager()

  private let db: Firestore
  private let userCollection: CollectionReference

  private init() {
    db = Firestore.firestore()
    userCollection = db.collection("users")
  }

  private func userDocument(_ userId: String) -> DocumentReference {
    userCollection.document(userId)
  }

  private let encoder: Firestore.Encoder = {
    let encoder = Firestore.Encoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
  }()

  private let decoder: Firestore.Decoder = {
    let decoder = Firestore.Decoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
}

// MARK: - User Management
extension FirebaseFirestoreManager {
  func createNewUser(for user: Usr) throws {
    try userDocument(user.uid).setData(from: user, encoder: encoder)
  }

  func fetchUser(for userId: String) async throws -> Usr {
    try await userDocument(userId).getDocument(as: Usr.self, decoder: decoder)
  }
}
