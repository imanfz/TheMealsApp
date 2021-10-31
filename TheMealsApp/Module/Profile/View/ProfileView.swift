//
//  ProfileView.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 31/10/21.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    content
  }
}

extension ProfileView {
  
  var imageProfile: some View {
    Image("iman")
      .resizable()
      .frame(
        width: 200,
        height: 250
      )
      .scaledToFit()
      .padding(.top)
  }
  
  var content: some View {
    VStack {
      imageProfile
      Text("Iman Faizal")
        .font(.title)
        .bold()
        .padding(.top)
      Text("imanfz1103@gmail.com")
        .font(.headline)
    }.navigationBarTitle(
      Text("Profile"),
      displayMode: .automatic
    ).edgesIgnoringSafeArea(.bottom)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
