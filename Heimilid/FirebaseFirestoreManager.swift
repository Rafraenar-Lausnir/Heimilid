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
  private let productCollection: CollectionReference

  private init() {
    db = Firestore.firestore()
    userCollection = db.collection("users")
    productCollection = db.collection("vorur")
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
    let user = try await userDocument(userId).getDocument(as: Usr.self, decoder: decoder)
    TmpData.shared.user = user
    return user
  }
}

// MARK: - Bank Account Management
extension FirebaseFirestoreManager {
  private func bankAccountCollection(_ userId: String) -> CollectionReference {
    userDocument(userId).collection("bank_accounts")
  }

  private func bankAccountTransactionCollection(_ userId: String, _ document: String) -> CollectionReference {
    bankAccountCollection(userId).document(document).collection("transactions")
  }

  func createNewAccount(_ account: BankAccount, for userId: String) throws {
    try bankAccountCollection(userId)
      .addDocument(from: account, encoder: encoder)
  }

  func fetchAccounts(for userId: String) async throws {
    let snapshot = try await bankAccountCollection(userId).getDocuments()
    let documents = snapshot.documents
    var bankAccounts: [BankAccount] = []
    for document in documents {
      let snapshotData = try document.data(as: BankAccount.self, decoder: decoder)
      let bankAccount = BankAccount(
        id: snapshotData.id,
        firestoreID: document.documentID,
        title: snapshotData.title,
        number: snapshotData.number,
        status: snapshotData.status,
        goal: snapshotData.goal,
        type: snapshotData.type
      )
      bankAccounts.append(bankAccount)
    }
    TmpData.shared.bankAccounts = bankAccounts
  }

  func createTransaction(_ transaction: BankAccountTransaction, for userId: String) async throws {
    guard let account = transaction.account, let documentID = account.firestoreID else {
      throw URLError(.unknown)
    }
    let newStatus = account.status + transaction.amount
    let updatedAccountStatus: [String: Any] = [
      "status": newStatus
    ]
    try await bankAccountCollection(userId)
      .document(documentID)
      .updateData(updatedAccountStatus)
    try bankAccountTransactionCollection(userId, documentID)
      .addDocument(from: transaction, encoder: encoder)

    try await TmpData.shared.loadBankAccounts()
  }
}

// MARK: - Product Management
extension FirebaseFirestoreManager {
  func fetchAllProducts() async throws -> [Product] {
    let snapshot = try await productCollection.getDocuments()
    let documents = snapshot.documents
    var products: [Product] = []
    for document in documents {
      let snapshotData = try document.data(as: Product.self, decoder: decoder)
      guard let barcode = Int(document.documentID) else {
        print("Sth not working")
        continue
      }
      let product = Product(
        snapshotData.heiti ?? "Innlestur vöruupplýsinga fór á villu",
        strm: barcode,
        flokkur: snapshotData.flokkur ?? "Óþekktur flokkur",
        mynd: snapshotData.mynd ?? "https://res.cloudinary.com/dnbvbcokm/image/upload/v1727044840/spurningarmerki.jpg",
        upplysingar: snapshotData.upplysingar ?? "Innlestur vöruupplýsinga fór á villu"
      )
      products.append(product)
    }
    return products
  }
}
