//
//  CategoriesResponse.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation

struct CategoriesResponse: Decodable {

  let categories: [CategoryItem]
  
}

struct CategoryItem: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id = "idCategory"
    case title = "strCategory"
    case image = "strCategoryThumb"
    case description = "strCategoryDescription"
  }

  let id: String?
  let title: String?
  let image: String?
  let description: String?

}
