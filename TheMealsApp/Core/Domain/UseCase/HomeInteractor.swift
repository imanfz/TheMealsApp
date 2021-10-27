//
//  HomeInteractor.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getCategories() -> AnyPublisher<[CategoryModel], Error>

}

class HomeInteractor: HomeUseCase {
  
  private let repository: MealRepositoryProtocol
  
  required init(repository: MealRepositoryProtocol) {
    self.repository = repository
  }
  
  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    return repository.getCategories()
  }

}
