//
//  ContentView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import SwiftUI
import Toaster

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  
  @State private var selection = 0
  @State private var resetNavigationID = UUID()
  
  var body: some View {
    let selectable = Binding(
      // << proxy binding to catch tab tap
      get: { self.selection },
      set: { self.selection = $0
        
      // set new ID to recreate NavigationView, so put it
      // in root state, same as is on change tab and back
      self.resetNavigationID = UUID()
    })
    
    TabView(selection: selectable) {
      NavigationView {
        HomeView(presenter: homePresenter)
      }.id(self.resetNavigationID)
      .tabItem {
        Image(
          systemName: selection == 0 ? "house.circle.fill" : "house.circle"
        ).renderingMode(.original)
        Text("Home")
      }.tag(0)
        
      NavigationView {
        FavoriteView(presenter: favoritePresenter)
      }.id(self.resetNavigationID)
      .tabItem {
        Image(
          systemName: selection == 1 ? "heart.circle.fill" : "heart.circle"
        ).renderingMode(.original)
        Text("Favorite")
      }.tag(1)
      
      NavigationView {
        ProfileView()
      }
      .tabItem {
          Image(
            systemName: selection == 2 ? "person.circle.fill" : "person.circle"
          ).renderingMode(.original)
          Text("Profile")
        }.tag(2)
    }.onAppear {
      configureAppearance()
      configureAccessibility()
    }.accentColor(Color.random)
  }
}

extension ContentView {
  
  func configureAppearance() {
    let appearance = ToastView.appearance()
    appearance.textInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    appearance.bottomOffsetPortrait = 60
    appearance.cornerRadius = 20
    appearance.maxWidthRatio = 0.7
  }

  func configureAccessibility() {
    ToastCenter.default.isSupportAccessibility = true
  }
  
}
