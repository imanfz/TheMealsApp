//
//  DetailMealEntity.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import Foundation
import RealmSwift

class DetailMealEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var drink_alternate: String = ""
  @objc dynamic var area: String = ""
  @objc dynamic var instruction: String = ""
  @objc dynamic var tags: String = ""
  @objc dynamic var category: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
