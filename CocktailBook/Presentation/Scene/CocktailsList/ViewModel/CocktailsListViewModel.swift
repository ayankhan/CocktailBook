//
//  CocktailsListViewModel.swift
//  CocktailBook
//
//  Created by Mohd on 31/01/25.
//

import Foundation
import Combine

final class CocktailsListViewModel: ObservableObject {
    enum FilterState: String, CaseIterable {
        case all = "All"
        case alcoholic = "Alcoholic"
        case nonAlcoholic = "Non-Alcoholic"
    }
    
    @Published var isLoading: Bool = true
    @Published var cocktails: Cocktails = []
    @Published var filterState: FilterState = .all
    @Published var errorMessage = ""
    
    private let cocktailsRepo: CocktailsRepository
    private let cocktailsStore: CocktailsStore
    
    init(
        cocktailsRepo: CocktailsRepository = CocktailsRepositoryImpl(),
        cocktailsStore: CocktailsStore = CocktailsStoreImpl()) {
            self.cocktailsRepo = cocktailsRepo
            self.cocktailsStore = cocktailsStore
        }
}

extension CocktailsListViewModel {
    var filteredCocktails: [Cocktail] {
        let filtered: [Cocktail]
        switch filterState {
        case .all:
            filtered = cocktails
        case .alcoholic:
            filtered = cocktails.filter { $0.type == .alcoholic }
        case .nonAlcoholic:
            filtered = cocktails.filter { $0.type == .nonAlcoholic  }
        }
        
        let favorites = filtered.filter { $0.isFavourite! }.sorted { $0.name < $1.name }
        let nonFavorites = filtered.filter { !$0.isFavourite! }.sorted { $0.name < $1.name }
        
        return favorites + nonFavorites
        
    }
    
    func fetchData() {
        self.isLoading = true
        self.fetchCocktails()
    }
    
    func updateFavourites() {
        cocktails = cocktails.map({ cocktail in
            var newCocktail = cocktail
            newCocktail.isFavourite = self.cocktailsStore.isFavourite(cocktail.id)
            return newCocktail
        })
    }
    
    private func fetchCocktails() {
        guard self.isLoading else { return }
        cocktailsRepo.fetchAllCocktails {completion in
            switch completion{
            case .success(let cocktails):
                DispatchQueue.main.async{
                    self.cocktails = cocktails
                    self.updateFavourites()
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
        
    }
}
