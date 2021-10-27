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
  static let getMealsDetail: (Int) -> String = { mealsId in
    return "\(API.baseUrl)lookup.php?i=\(mealsId)"
  }
  static let searchMealsByName: (String) -> String = { query in
    return "\(API.baseUrl)search.php?s=\(query)"
  }
}
