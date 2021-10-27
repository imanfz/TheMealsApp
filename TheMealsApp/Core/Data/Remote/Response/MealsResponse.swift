//
//  MealsResponse.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation

struct MealsResponse: Decodable {

  let meals: [MealItem]
  
}

struct MealItem: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id = "idMeal"
    case name = "strMeal"
    case image = "strMealThumb"
  }

  let id: String?
  let name: String?
  let image: String?

}
