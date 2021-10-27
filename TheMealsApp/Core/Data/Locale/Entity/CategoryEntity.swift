//
//  CategoryEntity.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation
import RealmSwift

class CategoryEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var desc: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
}
