//
//  ItemRowFavorite.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 31/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemRowFavorite: View {

  var meal: MealModel
  let Action: () -> Void
  
  var body: some View {
    HStack {
      imageMeal
      name
      spacer
      buttonFavorite
    }.frame(
      width: UIScreen.main.bounds.width - 56,
      height: 50,
      alignment: .leading
    ).padding(
      EdgeInsets(
        top: 8,
        leading: 16,
        bottom: 8,
        trailing: 16
      ))
    .background(Color.gray.opacity(0.2))
    .cornerRadius(20)
  }

}

extension ItemRowFavorite {
  
  var spacer: some View {
    Spacer()
  }

  var imageMeal: some View {
    WebImage(url: URL(string: meal.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 40, height: 40)
      .cornerRadius(5)
      .padding(.vertical, 8)
  }
  
  var name: some View {
    Text(meal.name)
      .font(.system(size: 12))
      .bold()
  }
  
  var buttonFavorite: some View {
    Button(action: {
      self.Action()
    }, label: {
      Image(systemName: "heart.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .foregroundColor(.red)
    })
  }

}
