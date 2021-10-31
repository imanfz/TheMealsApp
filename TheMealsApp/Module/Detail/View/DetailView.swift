//
//  DetailView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter
  @Environment(\.presentationMode) var presentation

  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        content
      }
    }.onAppear {
      if self.presenter.meal.count == 0 {
        self.presenter.getMealByCategory()
      }
    }.onDisappear {
      self.presenter.meal.removeAll()
    }.navigationBarTitle(
      Text(self.presenter.category.title),
      displayMode: .large
    ).navigationBarBackButtonHidden(true)
    .toolbar(content: {
        ToolbarItem(placement: .navigation) {
           Image(systemName: "arrow.left")
           .onTapGesture {
               // code to dismiss the view
               self.presentation.wrappedValue.dismiss()
           }
        }
     })
    .navigationTitle("Details")
    .edgesIgnoringSafeArea(.bottom)
  }
}

extension DetailView {
  
  var spacer: some View {
    Spacer()
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }

  var imageCategory: some View {
    WebImage(url: URL(string: self.presenter.category.image)
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

  var description: some View {
    Text(self.presenter.category.description)
      .font(.system(size: 15))
  }

  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        imageCategory
        VStack(alignment: .leading, spacing: 0) {
          headerTitle("Description")
            .padding([.top, .bottom])
          description
          spacer
          mealHeader
        }
        listItem
      }.padding(
        EdgeInsets(
          top: 0,
          leading: 24,
          bottom: 24,
          trailing: 24
        )
      )
    }
  }
  
  var mealHeader: some View {
    Text("List Meals:")
      .font(.system(size: 15))
  }
  
  var listItem: some View {
    ForEach(
      self.presenter.meal
    ) { meal in
      ItemRowMeal(meal: meal, Action: addRemoveFavorite(from: meal))
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
}
