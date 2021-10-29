//
//  HomeView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import SwiftUI

struct HomeView: View {

  @ObservedObject var presenter: HomePresenter
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          Text("Loading...")
          ActivityIndicator()
        }
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          ForEach(
            self.presenter.categories,
            id: \.id
          ) { category in
            ZStack {
              self.presenter.linkBuilder(for: category) {
                ItemRowCategory(category: category)
              }.buttonStyle(PlainButtonStyle())
            }.padding(8)
          }
        }
      }
    }.onAppear {
      if self.presenter.categories.count == 0 {
        self.presenter.getCategories()
      }
    }.navigationBarTitle(
      Text("Meals Apps"),
      displayMode: .automatic
    )
  }

}
