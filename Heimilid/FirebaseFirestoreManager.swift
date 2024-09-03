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
  private func userDocument(_ userId: String) -> DocumentReference {
    userCollection.document(userId)
  }

  func createNewUser(for user: Usr) throws {
    try userDocument(user.uid).setData(from: user, encoder: encoder)
  }

  func fetchUser(for userId: String) async throws -> Usr {
    try await userDocument(userId).getDocument(as: Usr.self, decoder: decoder)
  }
}

// MARK: - Bank Account Management
extension FirebaseFirestoreManager {
  private func bankAccountCollection(_ userId: String) -> CollectionReference {
    userDocument(userId).collection("bank_accounts")
  }

  func createNewAccount(_ account: BankAccount, for userId: String) throws {
    try bankAccountCollection(userId)
      .addDocument(from: account, encoder: encoder)
  }

  func fetchAccounts(for userId: String) async throws -> [BankAccount] {
    let snapshot = try await bankAccountCollection(userId).getDocuments()
    let documents = snapshot.documents
    var bankAccounts: [BankAccount] = []
    for document in documents {
      let bankAccount = try document.data(as: BankAccount.self, decoder: decoder)
      bankAccounts.append(bankAccount)
    }
    return bankAccounts
  }

  func createTransaction(_ transaction: BankAccountTransaction, for userId: String) throws {
    guard let documentID = transaction.firestoreID else {
      throw URLError(.unknown)
    }
    try bankAccountCollection(userId)
      .document(documentID)
      .collection("transactions")
      .addDocument(from: transaction, encoder: encoder)
  }
}
