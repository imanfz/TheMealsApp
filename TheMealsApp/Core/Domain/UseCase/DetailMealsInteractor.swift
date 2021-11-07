//
//  DetailMealsInteractor.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import Foundation
import Combine

protocol DetailMealsUseCase {
  
  func getId() -> String
  
  func getDetailMealById(id: String) -> AnyPublisher<DetailMealModel, Error>
  
}

class DetailMealsInteractor: DetailMealsUseCase {
  
  private let repository: MealRepositoryProtocol
  private let id: String
  
  required init(
    repository: MealRepositoryProtocol,
    id: String
  ) {
    self.repository = repository
    self.id = id
  }
  
  func getId() -> String {
    return id
  }
  
  func getDetailMealById(id: String) -> AnyPublisher<DetailMealModel, Error> {
    return repository.getDetailMeals(id: id)
  }
  
}
