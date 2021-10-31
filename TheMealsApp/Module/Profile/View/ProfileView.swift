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
  
  var spacer: some View {
    Spacer()
  }
  
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
      spacer
      imageProfile
      spacer
      Text("Iman Faizal")
        .font(.title)
        .bold()
      Text("imanfz1103@gmail.com")
        .font(.headline)
      spacer
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
