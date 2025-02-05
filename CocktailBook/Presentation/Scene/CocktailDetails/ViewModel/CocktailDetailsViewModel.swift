//
//  CocktailsListViewModel.swift
//  CocktailBook
//
//  Created by Mohd on 31/01/25.
//

import Foundation
import SwiftUI

final class CocktailDetailsViewModel: ObservableObject {
    @Published var cocktail: Cocktail
    private let cocktailsStore: CocktailsStore
    
    init(cocktail: Cocktail, cocktailsStore: CocktailsStore = CocktailsStoreImpl()) {
        self.cocktail = cocktail
        self.cocktailsStore = cocktailsStore
    }
}
extension CocktailDetailsViewModel{
    func toggleFavourite() {
        if let isFav = cocktail.isFavourite, isFav {
            cocktailsStore.removeFromFavourites(cocktail.id)
        } else {
            cocktailsStore.addToFavourites(cocktail.id)
        }
        cocktail.isFavourite = !(cocktail.isFavourite ?? false)
    }
}
