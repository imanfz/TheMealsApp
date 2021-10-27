//
//  MealEntity.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 27/10/21.
//

import Foundation
import RealmSwift

class MealEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var categoryName: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
}
