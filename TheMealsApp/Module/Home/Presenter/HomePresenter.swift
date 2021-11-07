//
//  HomePresenter.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {

  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  private var cancellables: Set<AnyCancellable> = []

  @Published var categories: [CategoryModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getCategories() {
    loadingState = true
    homeUseCase.getCategories()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { categories in
        self.categories = categories
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(
    for category: CategoryModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: category)) { content() }
  }

}
