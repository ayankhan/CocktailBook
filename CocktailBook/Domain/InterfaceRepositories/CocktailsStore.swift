//
//  CocktailsStore.swift
//  CocktailBook
//
//  Created by Mohd on 01/02/25.
//

protocol CocktailsStore {
    func addToFavourites(_ id: String)
    func removeFromFavourites(_ id: String)
    func isFavourite(_ id: String) -> Bool
}
