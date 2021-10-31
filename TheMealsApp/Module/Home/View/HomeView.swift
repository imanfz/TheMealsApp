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
        loadingIndicator
      } else {
        content
      }
    }.onAppear {
      if self.presenter.categories.count == 0 {
        self.presenter.getCategories()
      }
    }.navigationBarTitle(
      Text("Meals Categories"),
      displayMode: .automatic
    ).edgesIgnoringSafeArea(.bottom)
  }

}

extension HomeView {
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  var content: some View {
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
  
}
