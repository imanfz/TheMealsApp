//
//  DetailPresenter.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import Foundation

class DetailPresenter: ObservableObject {

  private let detailUseCase: DetailUseCase

  @Published var category: CategoryModel
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    category = detailUseCase.getCategory()
  }

}
