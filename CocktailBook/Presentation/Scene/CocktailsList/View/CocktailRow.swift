//
//  CocktailRow.swift
//  CocktailBook
//
//  Created by Mohd on 01/02/25.
//

import SwiftUI

struct CocktailRow: View {
    let cocktail: Cocktail
    
    var body: some View {
        HStack {
            Image(cocktail.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .cocktailIcon, height: .cocktailIcon)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text(cocktail.name)
                    .font(.headline)
                    .foregroundColor(cocktail.isFavourite ?? false ? .red : .primary)
                Text(cocktail.shortDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if let isFav = cocktail.isFavourite, isFav {
                Image.heartFill
                    .foregroundColor(.red)
            }
        }
    }
}
