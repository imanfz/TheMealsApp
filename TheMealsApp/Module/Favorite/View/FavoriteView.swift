//
//  FavoriteView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 29/10/21.
//

import SwiftUI

struct FavoriteView: View {
  
  @ObservedObject var presenter: FavoritePresenter
  @State var searchText: String = ""
  @State var searching: Bool = false
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        content
      }
    }.onAppear {
      self.presenter.getMealFavorite()
    }.navigationBarTitle(
      Text("My Meal Favorites"),
      displayMode: .automatic
    ).edgesIgnoringSafeArea(.bottom)
  }
}

extension FavoriteView {
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  var content: some View {
    VStack {
      SearchBar(
        text: $searchText,
        onSearchButtonClicked: hideKeyboard,
        onSearchCancelButtonClicked: hideKeyboard,
        placeHolder: "Search meal"
      )
      ScrollView(.vertical, showsIndicators: false) {
        ForEach(
          self.presenter.meals.filter {
            self.searchText.isEmpty ? true : $0.name.contains(self.searchText)
          }, id: \.id
        ) { meal in
          ZStack {
            ItemRowMeal(meal: meal, Action: addRemoveFavorite(from: meal))
          }.padding(
            EdgeInsets(
              top: 4,
              leading: 8,
              bottom: 4,
              trailing: 8
            )
          )
        }
      }
    }
  }
  
  func addRemoveFavorite(from meal: MealModel) -> () -> Void {
    return {
      var statusFavorite: Bool {
        if meal.favorite {
          return false
        } else {
          return true
        }
      }

      let updateMeal = MealModel(
        id: meal.id,
        name: meal.name,
        image: meal.image,
        favorite: statusFavorite,
        categoryName: meal.categoryName
      )
      self.presenter.addMealToFavorite(from: updateMeal)
    }
  }
  
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
  
}
