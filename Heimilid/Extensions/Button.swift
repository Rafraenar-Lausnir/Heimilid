//
//  Button.swift
//  Heimilid
//
//  Created by Elín Ósk on 7.9.2024.
//

import Foundation
import SwiftUI

public extension Button {
  func loading(_ isLoading: Bool) -> some View {
    self.environment(\.isLoading, isLoading)
  }
}
