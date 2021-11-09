//
//  DetailMealMapper.swift
//  TheMealsApp
//
//  Created by Iman Faizal on 04/11/21.
//

import Foundation

final class DetailMealMapper {
  static func mapDetailMealResponsesToDomains(
    input detailItems: DetailMeal
  ) -> DetailMealModel {
    return DetailMealModel(
      id: detailItems.id ?? "",
      name: detailItems.name ?? "Unknown",
      image: detailItems.image ?? "-",
      drinkAlternate: detailItems.drinkAlternate ?? "-",
      area: detailItems.area ?? "-",
      instruction: detailItems.instruction ?? "-",
      tags: detailItems.tags ?? "-",
      category: detailItems.category ?? "-"
    )
  }
  
  static func mapDetailMealResponsesToEntities(
    input detailItems: DetailMeal
  ) -> DetailMealEntity {
    let newDetail = DetailMealEntity()
    newDetail.id = detailItems.id ?? ""
    newDetail.name = detailItems.name ?? "Unknown"
    newDetail.image = detailItems.image ?? "-"
    newDetail.drink_alternate = detailItems.drinkAlternate ?? "-"
    newDetail.area = detailItems.area ?? "-"
    newDetail.instruction = detailItems.instruction ?? "-"
    newDetail.tags = detailItems.tags ?? "-"
    newDetail.category = detailItems.category ?? "-"
    return newDetail
  }
  
  static func mapDetailMealEntitiesToDomains(
    input detailEntities: DetailMealEntity
  ) -> DetailMealModel {
    return DetailMealModel(
      id: detailEntities.id,
      name: detailEntities.name,
      image: detailEntities.image,
      drinkAlternate: detailEntities.drink_alternate,
      area: detailEntities.area,
      instruction: detailEntities.instruction,
      tags: detailEntities.tags,
      category: detailEntities.category
    )
  }
  
}
