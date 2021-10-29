//
//  TabItem.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 29/10/21.
//

import SwiftUI

struct TabItem: View {

  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }
  
}
