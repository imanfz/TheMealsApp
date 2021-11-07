//
//  DetailPresenter.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import SwiftUI
import Combine
import Toaster

class DetailPresenter: ObservableObject {

  private let router = DetailRouter()
  private let detailUseCase: DetailUseCase
  private var cancellables: Set<AnyCancellable> = []

  @Published var category: CategoryModel
  @Published var meal: [MealModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  @Published var updateState: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    category = detailUseCase.getCategory()
  }

  func getMealByCategory() {
    loadingState = true
    detailUseCase.getMealByCategory(categoryName: self.category.title)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { meal in
        self.meal = meal
      })
      .store(in: &cancellables)
  }
  
  func addMealToFavorite(from meal: MealModel) {
    loadingState = true
    updateState = false
    detailUseCase.addMealToFavorite(from: meal)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { result in
        self.updateState = result
        
        if !meal.favorite {
          if self.updateState {
            Toast(text: "Successfuly remove \(meal.name) from favorites").show()
          } else {
            Toast(text: "Error, please try again").show()
          }
        } else {
          if self.updateState {
            Toast(text: "Successfuly add \(meal.name) to favorites").show()
          } else {
            Toast(text: "Error, please try again").show()
          }
        }
        self.getMealByCategory()
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(
    for id: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: id)) {
      content()
    }
  }
  
}
