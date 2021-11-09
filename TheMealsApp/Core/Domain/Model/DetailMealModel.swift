//
//  DetailMealModel.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import Foundation

struct DetailMealModel: Equatable, Identifiable {
  
  let id: String?
  let name: String?
  let image: String?
  let drinkAlternate: String?
  let area: String?
  let instruction: String?
  let tags: String?
  let category: String?
  
  init(
    id: String? = "",
    name: String? = "",
    image: String? = "",
    drinkAlternate: String? = "",
    area: String? = "",
    instruction: String? = "",
    tags: String? = "",
    category: String? = ""
  ) {
    self.id = id
    self.name = name
    self.image = image
    self.drinkAlternate = drinkAlternate
    self.area = area
    self.instruction = instruction
    self.tags = tags
    self.category = category
  }
  
}
