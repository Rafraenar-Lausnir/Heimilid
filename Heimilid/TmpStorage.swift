//
//  TmpStorage.swift
//  Admin
//
//  Created by Elín Ósk on 17.8.2024.
//

import Foundation

final class TmpStorage {
  static let shared = TmpStorage()
  private init() { }

  var user: Usr? = nil
}
