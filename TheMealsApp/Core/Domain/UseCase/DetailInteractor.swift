//
//  DetailInteractor.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import Foundation
import Combine

protocol DetailUseCase {

  func getCategory() -> CategoryModel
  func getMealByCategory(categoryName: String) -> AnyPublisher<[MealModel], Error>
  
  func addMealToFavorite(from meal: MealModel) -> AnyPublisher<Bool, Error>

}

class DetailInteractor: DetailUseCase {
  
  private let repository: MealRepositoryProtocol
  private let category: CategoryModel

  required init(
    repository: MealRepositoryProtocol,
    category: CategoryModel
  ) {
    self.repository = repository
    self.category = category
  }

  func getCategory() -> CategoryModel {
    return category
  }
  
  func getMealByCategory(categoryName: String) -> AnyPublisher<[MealModel], Error> {
    return repository.getMealsByCategory(categoryName: categoryName)
  }
  
  func addMealToFavorite(from meal: MealModel) -> AnyPublisher<Bool, Error> {
    return repository.addMealsToFavorite(from: meal)
  }
  
}
