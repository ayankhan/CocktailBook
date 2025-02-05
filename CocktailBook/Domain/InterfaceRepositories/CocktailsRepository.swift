//
//  CocktailsRepositories.swift
//  CocktailBook
//
//  Created by Mohd on 31/01/25.
//

/// THOUGH WE HAVE CocktailsAPI CLASS ALREADY, CREATING THIS TO SHOWCASE ALL THE LAYERS OF MVVM

import CocktailsAPI
protocol CocktailsRepository {
    func fetchAllCocktails(completion: @escaping (Result<Cocktails,Error>) -> Void)
}
