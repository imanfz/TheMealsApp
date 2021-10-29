//
//  ContentView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  
  var body: some View {
    TabView {
      NavigationView {
        HomeView(presenter: homePresenter)
      }.tabItem {
          Image(systemName: "Home.fill")
          Text("Home")
        }
      NavigationView {
        FavoriteView()
      }.tabItem {
          Image(systemName: "Favorite.fill")
          Text("Favorite")
        }
    }.background(Color.black)
  }
}
