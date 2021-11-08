//
//  DetailMealView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMealView: View {
  @ObservedObject var presenter: DetailMealsPresenter
  @Environment(\.presentationMode) var presentation
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        content
      }
    }.onAppear {
      if (self.presenter.details.id?.isEmpty) != nil {
        self.presenter.getDetails()
      }
    }.navigationBarBackButtonHidden(true)
      .toolbar(content: {
          ToolbarItem(placement: .navigation) {
             Image(systemName: "arrow.left")
              .foregroundColor(.blue)
              .onTapGesture {
                self.presentation.wrappedValue.dismiss()
              }
          }
       })
      .navigationBarTitle(
      Text(self.presenter.details.name ?? "Unknown"),
      displayMode: .large
    ).edgesIgnoringSafeArea(.bottom)
  }
}

extension DetailMealView {
  
  var spacer: some View {
    Spacer()
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ProgressView()
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
      ).padding(.top)
  }
  
  func rowText(_ labels: String, descriptions: String) -> some View {
    return HStack(alignment: .top, spacing: 10) {
      Text(labels)
        .font(.system(size: 15)).bold()
        .frame(minWidth: 120, alignment: .leading)
      Text(":")
      Text(descriptions)
        .font(.body)
    }
  }
  
  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        imageMeal(self.presenter.details.image ?? "-")
        VStack(alignment: .leading, spacing: 10) {
          rowText("Category", descriptions: self.presenter.details.category ?? "-")
          rowText("Drink Alternate", descriptions: self.presenter.details.drinkAlternate ?? "-")
          rowText("Area", descriptions: self.presenter.details.area ?? "-")
          rowText("Instructions", descriptions: self.presenter.details.instruction ?? "-")
          rowText("Tags", descriptions: self.presenter.details.tags ?? "-")
        }.padding(
          EdgeInsets(
            top: 24,
            leading: 24,
            bottom: 24,
            trailing: 24
          )
        )
      }
    }.padding(.bottom, 50)
  }
}
