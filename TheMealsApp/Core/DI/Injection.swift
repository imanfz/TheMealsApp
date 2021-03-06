//
//  Injection.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  
  private func provideRepository() -> MealRepositoryProtocol {
    
    let realm = try? Realm()
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    
    return MealRepository.sharedInstance(locale, remote)
  }
  
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideDetail(category: CategoryModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, category: category)
  }
  
  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
  
  func providerDetailMeals(id: String) -> DetailMealsUseCase {
    let repository = provideRepository()
    return DetailMealsInteractor(repository: repository, id: id)
  }
  
}
