//
//  Sushi.swift
//  SushiLover
//
//  Created by Derrick Park on 5/20/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
  let name: String
  let category: Category
    let image: String
  
  enum Category: Decodable {
    case all
    case mexican
    case asian
    case american
    case breakfast
    case lunch
  }
}

extension Restaurant.Category: CaseIterable { }

extension Restaurant.Category: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: String) {
    switch rawValue {
      case "All": self = .all
        case "Mexican": self = .mexican
        case "Asian": self = .asian
        case "American": self = .american
        case "Breakfast": self = .breakfast
        case "lunch": self = .lunch
      default:
        return nil
    }
  }
  
  var rawValue: String {
    switch self {
      case .all: return "All"
        case .mexican: return "Mexican"
        case .asian: return "Asian"
        case .american: return "American"
        case .breakfast: return "Breakfast"
        case .lunch: return "Lunch"
    }
  }
}

extension Restaurant {
  static func restaurants() -> [Restaurant] {
    guard
      let url = Bundle.main.url(forResource: "Restaurant", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else { return [] }
    
    do {
      return try JSONDecoder().decode([Restaurant].self, from: data)
    } catch {
      return []
    }
  }
}
