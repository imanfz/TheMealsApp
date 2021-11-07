//
//  ApiService.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation

struct API {
  static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
}

struct ApiService {
  static let getCategories: String = "\(API.baseUrl)categories.php"
  
  static let getMealsByCategory: (String) -> String = { categoryName in
    return "\(API.baseUrl)filter.php?c=\(categoryName)"
  }
  
  static let getDetailMeals: (String) -> String = { mealsId in
    return "\(API.baseUrl)lookup.php?i=\(mealsId)"
  }
}
