//
//  DetailRouter.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import SwiftUI

class DetailRouter {
  
  func makeDetailView(for id: String) -> some View {
    let detailMealUseCase = Injection.init().providerDetailMeals(id: id)
    let presenter = DetailMealsPresenter(detailsUseCase: detailMealUseCase)
    return DetailMealView(presenter: presenter)
  }
}
