//
//  FavoriteInteractor.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import Foundation

protocol FavoriteUseCase {

  func getFavorite() -> MealModel

}

class FavoriteInteractor: FavoriteUseCase {

  private let repository: MealRepositoryProtocol
  private let meal: MealModel

  required init(
    repository: MealRepositoryProtocol,
    meal: MealModel
  ) {
    self.repository = repository
    self.meal = meal
  }

  func getFavorite() -> MealModel {
    return meal
  }

}
