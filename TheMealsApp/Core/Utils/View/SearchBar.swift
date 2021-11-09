//
//  SearchBar.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
  
  @Binding var text: String
  var onSearchButtonClicked: (() -> Void)?
  var onSearchCancelButtonClicked: (() -> Void)?
  var placeHolder: String
  
  class Coordinator: NSObject, UISearchBarDelegate {
    
    let control: SearchBar
    
    init(_ control: SearchBar) {
      self.control = control
    }
    
    func searchBar(
      _ searchBar: UISearchBar,
      textDidChange searchText: String
    ) {
      control.text = searchText
    }
    
    func searchBarSearchButtonClicked(
      _ searchBar: UISearchBar
    ) {
      control.onSearchButtonClicked?()
    }
    
    func searchBarCancelButtonClicked(
      _ searchBar: UISearchBar
    ) {
      control.onSearchCancelButtonClicked?()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  func makeUIView(
    context: UIViewRepresentableContext<SearchBar>
  ) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.placeholder = placeHolder
    searchBar.backgroundImage = UIImage()
    return searchBar
  }
  
  func updateUIView(
    _ uiView: UISearchBar,
    context: UIViewRepresentableContext<SearchBar>
  ) {
    uiView.text = text
  }
  
}
