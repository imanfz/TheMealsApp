//
//  MealMapper.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation

final class MealMapper {
  
  static func mapMealResponsesToDomains(
    input mealItems: [MealItem],
    categoryName: String
  ) -> [MealModel] {

    return mealItems.map { result in
      return MealModel(
        id: result.id ?? "",
        name: result.name ?? "Unknow",
        image: result.image ?? "Unknow",
        categoryName: categoryName
      )
    }
  }
  
  static func mapMealResponsesToEntities(
    input mealItems: [MealItem],
    categoryName: String
  ) -> [MealEntity] {
    return mealItems.map { result in
      let newMeal = MealEntity()
      newMeal.id = result.id ?? ""
      newMeal.name = result.name ?? "Unknow"
      newMeal.image = result.image ?? "Unknow"
      newMeal.category_name = categoryName
      return newMeal
    }
  }
   
  static func mapMealEntitiesToDomains(
    input mealEntities: [MealEntity]
  ) -> [MealModel] {
    return mealEntities.map { result in
      return MealModel(
        id: result.id,
        name: result.name,
        image: result.image,
        categoryName: result.category_name
      )
    }
  }
  
}
