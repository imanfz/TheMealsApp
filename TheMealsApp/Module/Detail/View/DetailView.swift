//
//  DetailView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 28/10/21.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter
  @ObservedObject var detailPresenter: DetailMealsPresenter
  @Environment(\.presentationMode) var presentation
  @State var presented: Bool = false
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        content
      }
    }
    .onAppear {
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
            .foregroundColor(.blue)
            .onTapGesture {
              self.presentation.wrappedValue.dismiss()
            }
        }
      })
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
      ProgressView()
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
  
  var capsuleLine: some View {
    Capsule()
      .fill(Color.secondary.opacity(0.5))
      .frame(width: 50, height: 6)
      .padding(10)
  }
  
  var description: some View {
    Text(self.presenter.category.description)
      .font(.system(size: 15))
  }
  
  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }
  
  func mealTitle(_ title: String) -> some View {
    return Text(title)
      .font(.title)
      .bold()
  }
  
  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        imageCategory
        VStack(alignment: .leading, spacing: 0) {
          headerTitle("Description")
            .padding(.top)
          description
          spacer
          headerTitle("List Meals:")
        }
        listItem
      }.padding(
        EdgeInsets(
          top: 0,
          leading: 24,
          bottom: 24,
          trailing: 24
        )
      ).sheet(isPresented: $presented) {
        VStack {
          capsuleLine
          spacer
          mealTitle(self.detailPresenter.details.name ?? "Unknown")
          DetailMealView(presenter: detailPresenter)
        }.padding(.top)
      }
    }.padding(.bottom, 50)
  }
  
  var listItem: some View {
    ForEach(
      self.presenter.meal
    ) { meal in
      ZStack {
        
        ItemRowMeal(meal: meal, Action: addRemoveFavorite(from: meal)).buttonStyle(PlainButtonStyle())
          .onTapGesture {
            self.detailPresenter.id = meal.id
            self.presented = true
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
  
}
