//
//  ProductDetailsView.swift
//  Heimilid
//
//  Created by Elín Ósk on 22.9.2024.
//

import SwiftUI

struct ProductDetailsView: View {

  @State private var isEditingProduct: Bool = false
  @State private var title: String
  @State private var type: String
  @State private var description: String
  var product: Product

  init(product: Product) {
    self.product = product
    self.title = product.heiti ?? ""
    self.type = product.flokkur ?? ""
    self.description = product.upplysingar ?? ""
  }

  var body: some View {
    VStack(alignment: .center) {
        AsyncImage(url: URL(string: product.mynd ?? "https://res.cloudinary.com/dnbvbcokm/image/upload/v1727044840/spurningarmerki.jpg")) { image in
          image.resizable()
        } placeholder: {
          Color.orange.opacity(0.2)
        }
        .scaledToFit()
        .frame(width: 250, height: 250)
        .clipShape(.rect(cornerRadius: 50))
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
      VStack(alignment: .leading) {
        Text(product.heiti ?? "Vöruupplýsingar vantar")
          .font(.title)
        Text(product.upplysingar ?? "Vöruupplýsingar vantar")
      }
      .frame(maxWidth: .infinity)
      Spacer()
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Image(systemName: "gear")
          .onTapGesture {
            isEditingProduct = true
          }
      }
    }
    .sheet(isPresented: $isEditingProduct) {
      editProductSheet
    }
  }
}

extension ProductDetailsView {
  var editProductSheet: some View {
    VStack {
      AsyncImage(url: URL(string: product.mynd ?? "https://res.cloudinary.com/dnbvbcokm/image/upload/v1727044840/spurningarmerki.jpg")) { image in
        image.resizable()
      } placeholder: {
        Color.orange.opacity(0.2)
      }
      .scaledToFit()
      .frame(width: 150, height: 150)
      .clipShape(.rect(cornerRadius: 50))
      .frame(maxWidth: .infinity)
      .background(Color.gray.opacity(0.2))

      VStack {
        TextField(self.title, text: $title)
        TextField(self.type, text: $type)
        TextField(self.description, text: $description, axis: .vertical)
          .lineLimit(15)
          .multilineTextAlignment(.leading)
      }
      .padding()
      Spacer()
      Btn(label: "Breyta")
    }
    .overlay(alignment: .topTrailing) {
      Image(systemName: "xmark.circle")
        .resizable()
        .frame(width: 25, height: 25)
        .padding()
        .onTapGesture {
          self.title = product.heiti ?? ""
          self.type = product.flokkur ?? ""
          self.description = product.upplysingar ?? ""
          self.isEditingProduct = false
        }
    }
  }
}

#Preview {
  ProductDetailsView(
    product: Product("", strm: nil, flokkur: "", mynd: "", upplysingar: "")
  )
}
