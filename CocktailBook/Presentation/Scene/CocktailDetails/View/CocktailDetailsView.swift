//
//  CocktailsListView.swift
//  CocktailBook
//
//  Created by Mohd on 31/01/25.
//

import SwiftUI

struct CocktailDetailsView: View {
    @ObservedObject var viewModel: CocktailDetailsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(viewModel.cocktail.name)
                        .font(.largeTitle)
                    Spacer()
                    HStack {
                        Image.clock
                        Text("\(viewModel.cocktail.preparationMinutes) \(Strings.minutes)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                    HStack {
                        Spacer()
                        Image(viewModel.cocktail.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: .cocktailFullImage)
                            .clipped()
                        Spacer()
                    }
                    Text(viewModel.cocktail.longDescription)
                        .padding()
                    Text(Strings.ingredients)
                        .font(.headline)
                        .padding([.leading, .trailing, .top])
                    ForEach(viewModel.cocktail.ingredients, id: \.self) { ingredient in
                        HStack {
                            Image.arrowtriangle
                            Text(ingredient)
                        }
                        .padding([.leading, .trailing, .bottom], .padding5)
                    }
                    Spacer()
                }
                .padding()
                .frame(width: geometry.size.width)
            }
        }
        .navigationBarItems(trailing: Button(action: {
            viewModel.toggleFavourite()
        }) {
            (viewModel.cocktail.isFavourite ?? false) ? Image.heartFill : Image.heart
        })
    }
}

