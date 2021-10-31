//
//  ItemRowMeal.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 29/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemRowMeal: View {

  var meal: MealModel
  @State var selection: Int = 0
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
      )
    )
    .background(Color.random.opacity(0.2))
    .cornerRadius(20)
    .onAppear {
      // check status favorite of meals
      switch meal.favorite {
      case true:
        selection = 1
      default:
        selection = 0
      }
    }
  }

}

extension ItemRowMeal {
  
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
      
      // update state on item clicked
      switch selection {
      case 0:
        selection = 1
      default:
        selection = 0
      }
    }, label: {
      Image(
        systemName: selection == 1 ? "heart.circle.fill" : "heart.circle"
      ).resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .foregroundColor(
          selection == 1 ? .red : .gray
        )
    })
  }

}
