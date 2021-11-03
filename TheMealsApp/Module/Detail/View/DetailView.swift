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
  @Environment(\.presentationMode) var presentation
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
             if self.isPresented {
               self.isPresented = false
             } else {
               // code to dismiss the view
               self.presentation.wrappedValue.dismiss()
             }
           }
        }
     })
    .navigationTitle("Details")
    .edgesIgnoringSafeArea(.bottom)
    .modifier(PopupView(
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
}

extension DetailView {
  
  func handleTap(_ meal: MealModel) {
    self.selectedMeal = meal
    self.isPresented = true
  }
  
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
        .onTapGesture {
          self.handleTap(meal)
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
