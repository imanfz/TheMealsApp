//
//  HomeView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var presenter: HomePresenter
  @State var searchText: String = ""
  
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
      ProgressView()
    }
  }
  
  var content: some View {
    VStack {
      SearchBar(
        text: $searchText,
        onSearchButtonClicked: hideKeyboard,
        onSearchCancelButtonClicked: hideKeyboard,
        placeHolder: "Search category"
      ).padding(.horizontal, 8)
      ScrollView(.vertical, showsIndicators: false) {
        ForEach(
          self.presenter.categories.filter {
            self.searchText.isEmpty ? true : $0.title.contains(self.searchText)
          },
          id: \.id
        ) { category in
          
          ZStack {
            self.presenter.linkBuilder(for: category) {
              ItemRowCategory(category: category)
            }.buttonStyle(PlainButtonStyle())
          }.padding(
            EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)
          )
        }
      }
    }.padding(.bottom, 50)
  }
  
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
  
}
