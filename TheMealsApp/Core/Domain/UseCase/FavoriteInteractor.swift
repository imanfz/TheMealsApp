//
//  FavoriteInteractor.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {

  func getMealFavorite() -> AnyPublisher<[MealModel], Error>
  
  func addMealToFavorite(from meal: MealModel) -> AnyPublisher<Bool, Error>

}

class FavoriteInteractor: FavoriteUseCase {

  private let repository: MealRepositoryProtocol

  required init(
    repository: MealRepositoryProtocol
  ) {
    self.repository = repository
  }
  
  func getMealFavorite() -> AnyPublisher<[MealModel], Error> {
    return repository.getMealsFavorite()
  }
  
  func addMealToFavorite(from meal: MealModel) -> AnyPublisher<Bool, Error> {
    return repository.addMealsToFavorite(from: meal)
  }

}
