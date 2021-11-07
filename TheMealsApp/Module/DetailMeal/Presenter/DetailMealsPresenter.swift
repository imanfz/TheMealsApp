//
//  DetailMealsPresenter.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import SwiftUI
import Combine

class DetailMealsPresenter: ObservableObject {
  
  private let detailsUseCase: DetailMealsUseCase
  private var cancellables: Set<AnyCancellable> = []

  @Published var id: String
  @Published var details: DetailMealModel = DetailMealModel()
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(detailsUseCase: DetailMealsUseCase) {
    self.detailsUseCase = detailsUseCase
    id = detailsUseCase.getId()
  }
  
  func getDetails() {
    loadingState = true
    detailsUseCase.getDetailMealById(id: self.id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { details in
        print(details)
        self.details = details
      })
      .store(in: &cancellables)
  }
  
}
