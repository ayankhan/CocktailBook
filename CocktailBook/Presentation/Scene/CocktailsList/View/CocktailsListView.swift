//
//  CocktailsListView.swift
//  CocktailBook
//
//  Created by Mohd on 31/01/25.
//

import SwiftUI

struct CocktailsListView: View {
    @ObservedObject private var viewModel: CocktailsListViewModel = CocktailsListViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                if #available(iOS 14.0, *) {
                    ProgressView(Strings.loading)
                        .padding()
                } else {
                    Text(Strings.loading)
                }
            } else if viewModel.cocktails.isEmpty {
                VStack {
                    Text(Strings.noData)
                        .font(.headline)
                        .padding()
                    Button{
                        viewModel.fetchData()
                    } label: {
                        Image.retry
                            .resizable()
                            .scaledToFit()
                        .frame(width: .retry, height: .retry)}
                }
            } else {
                VStack {
                    Picker(Strings.pickerLable, selection: $viewModel.filterState) {
                        ForEach(CocktailsListViewModel.FilterState.allCases, id: \.self) { state in
                            Text(state.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing])
                    List(viewModel.filteredCocktails) { cocktail in
                        NavigationLink(destination: CocktailDetailsView(viewModel: CocktailDetailsViewModel(cocktail: cocktail))) {
                            CocktailRow(cocktail: cocktail)
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationBarTitle(Text(viewModel.filterState.rawValue), displayMode: .large)
                .onAppear {
                    viewModel.updateFavourites()
                }
                
            }
        }
        .accentColor(.red)
        .alert(isPresented: .constant(!viewModel.errorMessage.isEmpty)) {
            Alert(
                title: Text(Strings.error),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text(Strings.ok)) {
                    viewModel.errorMessage = ""
                }
            )
        }
        .onAppear {
            viewModel.fetchData()
        }
        
    }
}

#Preview {
    CocktailsListView()
}
