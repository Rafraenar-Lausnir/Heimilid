//
//  Button.swift
//  Admin
//
//  Created by Elín Ósk on 15.8.2024.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    PrimaryButton(configuration: configuration)
  }
}

struct PrimaryButton: View {
  @Namespace private var animation
  @Environment(\.isEnabled) private var isEnabled: Bool
  @Environment(\.isLoading) private var isLoading: Bool

  let configuration: ButtonStyleConfiguration

  var body: some View {
    Group {
      if isLoading {
        ZStack {
          Circle()
            .fill(.blue)
            .frame(height: 60)

          ProgressView()
            .tint(.white)
        }
        .matchedGeometryEffect(id: "button", in: animation)
      } else {
        configuration.label
          .font(.body)
          .foregroundStyle(isEnabled ? .white : .secondary.opacity(0.3))
          .frame(maxWidth: .infinity)
          .frame(height: 60)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(isEnabled ? .blue : .gray.opacity(0.5))
          )
          .matchedGeometryEffect(id: "button", in: animation)
      }
    }
  }
}

struct Btn: View {

  var label: String

  var body: some View {
    Text(label)
      .padding()
      .padding(.horizontal)
      .foregroundStyle(Color("bg_color"))
      .bold()
      .background(Color("text_color"))
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

#Preview {
  Btn(label: "Skrá inn")
}
