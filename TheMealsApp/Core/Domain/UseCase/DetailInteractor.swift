//
//  DetailInteractor.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import Foundation

protocol DetailUseCase {

  func getCategory() -> CategoryModel
  func getMealByCategory() -> MealModel

}

class DetailInteractor: DetailUseCase {

  private let repository: MealRepositoryProtocol
  private let category: CategoryModel
  private let meal: MealModel

  required init(
    repository: MealRepositoryProtocol,
    category: CategoryModel,
    meal: MealModel
  ) {
    self.repository = repository
    self.category = category
    self.meal = meal
  }

  func getCategory() -> CategoryModel {
    return category
  }

  func getMealByCategory() -> MealModel {
    return meal
  }
}
