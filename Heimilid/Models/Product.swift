//
//  Product.swift
//  Heimilid
//
//  Created by Elín Ósk on 22.9.2024.
//

import Foundation

struct Product: Codable {
  let strm: Int?
  let heiti: String?
  let flokkur: String?
  let mynd: String?
  let upplysingar: String?

  init(_ heiti: String, strm: Int?, flokkur: String, mynd: String, upplysingar: String) {
    self.strm = strm
    self.heiti = heiti
    self.flokkur = flokkur
    self.mynd = mynd
    self.upplysingar = upplysingar
  }
}
