//
//  MealRepository.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation
import Combine

protocol MealRepositoryProtocol {
  
  func getCategories() -> AnyPublisher<[CategoryModel], Error>
  
  func getMealsByCategory(categoryName: String) -> AnyPublisher<[MealModel], Error>
  
  func getMealsFavorite() -> AnyPublisher<[MealModel], Error>
  
  func addMealsToFavorite(from meal: MealModel) -> AnyPublisher<Bool, Error>
}

final class MealRepository: NSObject {
  
  typealias MealInstance = (LocaleDataSource, RemoteDataSource) -> MealRepository
  fileprivate let locale: LocaleDataSource
  fileprivate let remote: RemoteDataSource
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }
  static let sharedInstance: MealInstance = { localeRepo, remoteRepo in
    return MealRepository(locale: localeRepo, remote: remoteRepo)
  }
  
}

extension MealRepository: MealRepositoryProtocol {
  
  func getCategories() -> AnyPublisher<[CategoryModel], Error> {
    return self.locale.getCategories()
      .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
        if result.isEmpty {
          return self.remote.getCategories()
            .map { CategoryMapper.mapCategoryResponsesToEntities(input: $0) }
            .flatMap { self.locale.addCategories(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getCategories()
              .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getCategories()
            .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getMealsByCategory(categoryName: String) -> AnyPublisher<[MealModel], Error> {
    return self.locale.getMealByCategory(categoryName: categoryName)
      .flatMap { result -> AnyPublisher<[MealModel], Error> in
        if result.isEmpty {
          return self.remote.getMealByCategory(categoryName: categoryName)
            .map { MealMapper.mapMealResponsesToEntities(input: $0, categoryName: categoryName) }
            .flatMap { self.locale.addMeals(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getMealByCategory(categoryName: categoryName)
              .map { MealMapper.mapMealEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getMealByCategory(categoryName: categoryName)
            .map {
              MealMapper.mapMealEntitiesToDomains(input: $0)
            }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getMealsFavorite() -> AnyPublisher<[MealModel], Error> {
    return self.locale.getMealFavorite()
      .map {
        MealMapper.mapMealEntitiesToDomains(input: $0)
      }.eraseToAnyPublisher()
  }
  
  func addMealsToFavorite(from meal: MealModel) -> AnyPublisher<Bool, Error> {
    return self.locale.addMealToFavorite(from: MealMapper.mapMealDomainsToEntities(input: meal))
  }
  
}
