//
//  CocktailsStore.swift
//  CocktailBook
//
//  Created by Mohd on 01/02/25.
//

import Foundation

final class CocktailsStoreImpl {
    /// INTENTIONALLY NOT USING CORE DATA SINCE ONLY IDs ARE REQUIRED TO STORE, PLIST WAS ALSO ANOTHER OPTION FOR THIS TYPE OF SIMPLE DATA STORAGE BUT GOING WITH USERDEFAULTS
    private let store: UserDefaults
    private let favoritesKey = "favoriteCocktails"
    init(store: UserDefaults = UserDefaults.standard) {
        self.store = store
    }
}

// MARK: - CocktailsStore
extension CocktailsStoreImpl: CocktailsStore {
    func addToFavourites(_ id: String) {
        var favorites =  loadFavorites()
        if !favorites.contains(id) {
            favorites.append(id)
            saveFavorites(favorites)
        }
    }
    
    func removeFromFavourites(_ id: String) {
        var favorites = loadFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }
    
    func isFavourite(_ id: String) -> Bool {
        return loadFavorites().contains(id)
    }
    
    private func saveFavorites(_ favorites: [String]) {
        store.set(favorites, forKey: favoritesKey)
    }
    
    private func loadFavorites() -> [String] {
        return store.stringArray(forKey: favoritesKey) ?? []
    }
    
}
