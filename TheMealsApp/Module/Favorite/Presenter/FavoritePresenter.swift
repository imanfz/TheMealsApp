//
//  FavoritePresenter.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 31/10/21.
//

import SwiftUI
import Combine
import Toaster

class FavoritePresenter: ObservableObject {
  
  private let router = DetailRouter()
  private let favoriteUseCase: FavoriteUseCase
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var meals: [MealModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  @Published var updateState: Bool = false
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getMealFavorite() {
    loadingState = true
    favoriteUseCase.getMealFavorite()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { meals in
        self.meals = meals
      })
      .store(in: &cancellables)
  }
  
  func addMealToFavorite(from meal: MealModel) {
    loadingState = true
    updateState = false
    favoriteUseCase.addMealToFavorite(from: meal)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
          self.objectWillChange.send()
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
        self.getMealFavorite()
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(
    for id: String,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: id)) { content() }
  }
  
}
