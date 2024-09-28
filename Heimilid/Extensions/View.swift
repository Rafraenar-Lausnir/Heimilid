//
//  View.swift
//  Heimilid
//
//  Created by Elín Ósk on 7.9.2024.
//

import Foundation
import SwiftUI

extension View {
  func underlineTextField() -> some View {
    self.padding(.vertical, 10)
      .overlay(Rectangle().frame(height: 2).padding(.top, 35))
      .foregroundStyle(Color("text_color"))
      .padding(10)
  }
}
