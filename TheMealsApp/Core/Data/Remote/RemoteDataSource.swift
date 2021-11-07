//
//  RemoteDataSource.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {

  func getCategories() -> AnyPublisher<[CategoryItem], Error>
  
  func getMealByCategory(categoryName: String) -> AnyPublisher<[MealItem], Error>
  
  func getDetailMeals(id: String) -> AnyPublisher<DetailMeal, Error>
  
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getCategories() -> AnyPublisher<[CategoryItem], Error> {
    return Future<[CategoryItem], Error> { completion in
      if let url = URL(string: ApiService.getCategories) {
        AF.request(url)
          .validate()
          .responseDecodable(of: CategoriesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.categories))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getMealByCategory(categoryName: String) -> AnyPublisher<[MealItem], Error> {
    return Future<[MealItem], Error> { completion in
      if let url = URL(string: ApiService.getMealsByCategory(categoryName)) {
        AF.request(url)
          .validate()
          .responseDecodable(of: MealsResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.meals))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailMeals(id: String) -> AnyPublisher<DetailMeal, Error> {
    return Future<DetailMeal, Error> { completion in
      if let url = URL(string: ApiService.getDetailMeals(id)) {
        AF.request(url)
          .validate()
          .responseDecodable(of: DetailMealsResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.meals[0]))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
}
