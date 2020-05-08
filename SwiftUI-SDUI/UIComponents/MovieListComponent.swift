//
//  MovieListComponent.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI


class MovieListUIComponent : UIComponent {
    let movieResult: MoviesResult
    var uniqueId: String
    
    init(movieResult: MoviesResult) {
        self.movieResult = movieResult
        self.uniqueId = movieResult.title ?? "Movies"
    }
    
    func render(uiDelegate: UIDelegate) -> AnyView {
        return MovieListView(movieResult: movieResult).toAny()
    }
}

struct MovieListView: View {
    let movieResult: MoviesResult
    
    var body: some View {
        VStack {
            HStack {
                Text(movieResult.title ?? "Movies" )
                    .font(.headline)
                
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movieResult.results, id: \.title) { movie in
                        MovieView(movie: movie)
                    }
                }
            }
        }
        .padding()
        
    }
}

struct MovieView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            
            KFImage(URL(string: "https://image.tmdb.org/t/p/w300/\(movie.poster_path)"))
                .resizable()
                .frame(width: 180, height: 270)
                .cornerRadius(20)
            
            Text(movie.title)
                .frame(width: 180, alignment: Alignment.center)
                .foregroundColor(.black)
                .lineLimit(1)
            
        }
        
    }
}


struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie(id: 12, title: "DDLJ", overview: "Boring movie", poster_path: ""))
    }
}
