//
//  Cocktail.swift
//  CocktailBook
//
//  Created by Mohd on 31/01/25.
//

import Foundation

// MARK: - Cocktail
struct Cocktail: Codable, Identifiable {
    let id, name: String
    let type: CocktailType
    let shortDescription, longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    var isFavourite: Bool? = false
}

enum CocktailType: String, Codable {
    case alcoholic = "alcoholic"
    case nonAlcoholic = "non-alcoholic"
}

typealias Cocktails = [Cocktail]
