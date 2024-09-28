//
//  EnvironmentValues.swift
//  Heimilid
//
//  Created by Elín Ósk on 7.9.2024.
//

import Foundation
import SwiftUI

public extension EnvironmentValues {
  var isLoading: Bool {
    get { self[LoadingKey.self] }
    set { self[LoadingKey.self] = newValue }
  }
}

struct LoadingKey: EnvironmentKey {
  static let defaultValue: Bool = false
}
