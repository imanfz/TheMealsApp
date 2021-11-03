//
//  PopupView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 03/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopupView<T: View>: ViewModifier {
  let popup: T
  let isPresented: Bool
  let alignment: Alignment // (*)

  init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: () -> T) { // (*)
    self.isPresented = isPresented
    self.alignment = alignment // (*)
    popup = content()
  }

  func body(content: Content) -> some View {
    content.overlay(popupContent())
  }

  @ViewBuilder private func popupContent() -> some View {
    GeometryReader { geometry in
      if isPresented {
        popup
          .animation(.spring())
          .transition(.offset(x: 0, y: geometry.belowScreenEdge))
          .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
      }
    }
  }
  
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}

struct PopupView_Previews: PreviewProvider {
  let meal = CategoryModel(
    id: "1",
    title: "Beef",
    image: "https://www.themealdb.com/images/category/beef.png",
    description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle."
  )
  
  static var previews: some View {
    Preview().previewDevice("iPod touch")
  }

  // Helper view that shows a popup
  struct Preview: View {
    @State var isPresented = false

    var body: some View {
      ZStack {
        Color.clear
        VStack {
          Button("Toggle", action: { isPresented.toggle() })
          Spacer()
        }
      }
      .modifier(PopupView(
        isPresented: isPresented,
        alignment: .center,
        content: {
          Color.yellow.frame(
            width: 100,
            height: 100
          ) }
      ))
    }
  }
}
