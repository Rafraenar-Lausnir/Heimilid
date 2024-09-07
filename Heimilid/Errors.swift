//
//  Errors.swift
//  Heimilid
//
//  Created by Elín Ósk on 7.9.2024.
//

import Foundation

enum LoginError: Error, CustomStringConvertible {
  /// Error thrown when an email field does not contain a valid email address
  case invalidEmail
  /// Error thrown when password is incorrect
  case invalidEmailPassword
  /// Error thrown when a password field does not contain password that meets set criteria
  case invalidPassword
  /// Error thrown when an unknown error happens
  case unknonwn(code: String)

  var isFatal: Bool {
    if case .unknonwn(let code) = self {
      return true
    } else {
      return false
    }
  }

  public var description: String {
    switch self {
    case .invalidEmail:
      return "Netfangið er á röngu formi."
    case .invalidEmailPassword:
      return "Netfang eða lykilorð er ekki rétt."
    case .invalidPassword:
      return "Lykilorðið er á röngu formi."
    case .unknonwn(_):
      return "Óþekkt villa hefur komið upp."
    }
  }
}
