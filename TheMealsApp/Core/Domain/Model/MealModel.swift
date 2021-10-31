//
//  MealModel.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation

struct MealModel: Equatable, Identifiable {

  let id: String
  let name: String
  let image: String
  var favorite: Bool
  let categoryName: String
  
}
