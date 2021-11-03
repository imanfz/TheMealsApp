//
//  FavoriteView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 29/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {
  
  @ObservedObject var presenter: FavoritePresenter
  @State var searchText: String = ""
  @State var searching: Bool = false
  @State var isPresented = false
  @State var selectedMeal: MealModel?
  
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
  
  func handleTap(_ meal: MealModel) {
    self.selectedMeal = meal
    self.isPresented = true
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  func imageMeal(_ urlImage: String) -> some View {
    return WebImage(url: URL(string: urlImage)
    ).resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .cornerRadius(20)
      .frame(
        width: 200.0,
        height: 200.0,
        alignment: .center
      )
  }
  
  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
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
            ItemRowFavorite(meal: meal, Action: addRemoveFavorite(from: meal))
              .onTapGesture {
                self.handleTap(meal)
              }
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
    }.modifier(PopupView(
      isPresented: isPresented,
      alignment: .center,
      content: {
        BlurView().onTapGesture {
          self.isPresented = false
        }.opacity(0.7)
        VStack(alignment: .center) {
          imageMeal(self.selectedMeal?.image ?? "")
          headerTitle(self.selectedMeal?.name ?? "")
        }.frame(
          width: 250,
          height: 300
        ).background(Color.white)
          .cornerRadius(30)
          .onTapGesture {
            self.isPresented = false
          }
        }
    ))
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
