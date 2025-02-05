//
//  CocktailsRepositoryImpl.swift
//  CocktailBook
//
//  Created by Mohd on 31/01/25.
//

import Foundation
import CocktailsAPI
import Combine

final class CocktailsRepositoryImpl {
    /// Ideally in the project, Here NetworkManager protocol will be declared and injected rather than CocktailsAPI
    private let cocktailsAPI: CocktailsAPI
    var cancellables = Set<AnyCancellable>()
    init(cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()) {
        self.cocktailsAPI = cocktailsAPI
    }
}

// MARK: - CocktailsRepository
extension CocktailsRepositoryImpl: CocktailsRepository {
    func fetchAllCocktails(completion: @escaping (Result<Cocktails,Error>) -> Void) {
        cocktailsAPI.cocktailsPublisher
            .sink(receiveCompletion: { completion in
                // Handle completion
            }, receiveValue: { (response: Data) in
                do {
                    let cocktails = try JSONDecoder().decode(Cocktails.self, from: response)
                    completion(.success(cocktails))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
                
            })
            .store(in: &cancellables)
    }
}
