//
//  DetailMealResponse.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import Foundation

struct DetailMealsResponse: Decodable {

  let meals: [DetailMeal]
  
}

struct DetailMeal: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id = "idMeal"
    case name = "strMeal"
    case image = "strMealThumb"
    case drinkAlternate = "strDrinkAlternate"
    case area = "strArea"
    case instruction = "strInstructions"
    case tags = "strTags"
    case category = "strCategory"
  }

  let id: String?
  let name: String?
  let image: String?
  let drinkAlternate: String?
  let area: String?
  let instruction: String?
  let tags: String?
  let category: String?
  
}
