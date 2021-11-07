//
//  HomeRouter.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import SwiftUI

class HomeRouter {
  
  func makeDetailView(for category: CategoryModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(category: category)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    
    let detailMealUseCase = Injection.init().providerDetailMeals(id: "")
    let detailPresenter = DetailMealsPresenter(detailsUseCase: detailMealUseCase)
    
    return DetailView(presenter: presenter, detailPresenter: detailPresenter)
  }
  
}
