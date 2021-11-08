//
//  LocaleDataSource.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
  
  func getCategories() -> AnyPublisher<[CategoryEntity], Error>
  func addCategories(from categories: [CategoryEntity]) -> AnyPublisher<Bool, Error>
  
  func getMealByCategory(categoryName: String) -> AnyPublisher<[MealEntity], Error>
  func addMeals(from meals: [MealEntity]) -> AnyPublisher<Bool, Error>
  
  func getMealFavorite() -> AnyPublisher<[MealEntity], Error>
  func addMealToFavorite(from meals: MealEntity) -> AnyPublisher<Bool, Error>
  
  func getDetailMeal(id: String) -> AnyPublisher<DetailMealEntity, Error>
  func addDetailMeal(from detail: DetailMealEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
  
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
  
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func getCategories() -> AnyPublisher<[CategoryEntity], Error> {
    return Future<[CategoryEntity], Error> { completion in
      if let realm = self.realm {
        let categories: Results<CategoryEntity> = {
          realm.objects(CategoryEntity.self)
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(categories.toArray(ofType: CategoryEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addCategories(from categories: [CategoryEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for category in categories {
              realm.add(category, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getMealByCategory(categoryName: String) -> AnyPublisher<[MealEntity], Error> {
    return Future<[MealEntity], Error> { completion in
      if let realm = self.realm {
        let meals: Results<MealEntity> = {
          realm.objects(MealEntity.self)
            .filter("category_name == %@", categoryName)
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(meals.toArray(ofType: MealEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addMeals(from meals: [MealEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for meal in meals {
              realm.add(meal, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getMealFavorite() -> AnyPublisher<[MealEntity], Error> {
    return Future<[MealEntity], Error> { completion in
      if let realm = self.realm {
        let meals: Results<MealEntity> = {
          realm.objects(MealEntity.self)
            .filter("favorite == %@", true)
            .sorted(byKeyPath: "name", ascending: false)
        }()
        completion(.success(meals.toArray(ofType: MealEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addMealToFavorite(from meal: MealEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(meal, update: .modified)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addDetailMeal(from detail: DetailMealEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(detail, update: .all)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailMeal(id: String) -> AnyPublisher<DetailMealEntity, Error> {
    return Future<DetailMealEntity, Error> { completion in
      if let realm = self.realm {
        let details: DetailMealEntity = {
          realm.object(ofType: DetailMealEntity.self, forPrimaryKey: id)
        }() ?? DetailMealEntity()
        completion(.success(details))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
