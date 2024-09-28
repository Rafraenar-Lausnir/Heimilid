//
//  ProductsListView.swift
//  Heimilid
//
//  Created by Elín Ósk on 22.9.2024.
//

import SwiftUI

struct ProductsListView: View {

  @State private var productsList: [Product] = [] {
    didSet {
      mapOutTypes()
    }
  }
  @State private var typeList: [String] = []

  var body: some View {
    List {
      ForEach(typeList, id: \.self) { type in
        Section(type) {
          productListByType(type)
        }
      }
    }
    .onAppear(perform: fetchProducts)
  }
}

extension ProductsListView {
  func mapOutTypes() {
    var typeList: [String] = []
    for product in productsList {
      guard let productType = product.flokkur else {
        continue
      }
      if typeList.contains(productType) {
        continue
      }
      else {
        typeList.append(productType)
      }
    }
    typeList.sort()
    self.typeList = typeList
  }

  func fetchProducts() {
    Task {
      do {
        let productList = try await FirebaseFirestoreManager.shared.fetchAllProducts()
        self.productsList = productList
      } catch let err {
        print("Error fetching products: \(err.localizedDescription)")
      }
    }
  }

  func productListByType(_ type: String) -> some View {
    let productListByType = productsList.filter { product in
      product.flokkur == type
    }
    return ForEach(productListByType, id: \.strm) { product in
      NavigationLink {
        ProductDetailsView(product: product)
      } label: {
        HStack {
          AsyncImage(url: URL(string: product.mynd ?? "https://res.cloudinary.com/dnbvbcokm/image/upload/v1727044840/spurningarmerki.jpg")) { image in
            image.resizable()
          } placeholder: {
            Color.orange.opacity(0.2)
          }
          .scaledToFit()
          .frame(width: 50, height: 50)
          .clipShape(.rect(cornerRadius: 15))
          Text(product.heiti ?? "Innlestur vöruupplýsinga tókst ekki")
        }
      }
    }
  }
}

#Preview {
  ProductsListView()
}
