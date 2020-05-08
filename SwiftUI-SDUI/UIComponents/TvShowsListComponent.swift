//
//  TvShowsListComponent.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

class TvShowsListUIComponent : UIComponent {
    let tvShowsResult: TvShowsResult
    var uniqueId: String
    
    init(tvShowsResult: TvShowsResult) {
        self.tvShowsResult = tvShowsResult
        self.uniqueId = tvShowsResult.title ?? "shows"
    }
    
    func render(uiDelegate: UIDelegate) -> AnyView {
        return TvShowListView(tvShowsResult: tvShowsResult).toAny()
    }
}

struct TvShowListView: View {
    
    let tvShowsResult: TvShowsResult
    
    var body: some View {
        VStack {
            HStack {
                Text(tvShowsResult.title ?? "Popular Shows")
                    .font(.headline)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tvShowsResult.results, id: \.name) { show in
                        TvShowView(show: show)
                    }
                }
            }
        }
        .padding()
        
    }
}

struct TvShowView: View {
    let show: TvShow
    
    var body: some View {
        VStack {
            
            KFImage(URL(string: "https://image.tmdb.org/t/p/w300/\(show.poster_path)"))
                .resizable()
                .frame(width: 180, height: 270)
                .cornerRadius(20)
            
            Text(show.name)
                .frame(width: 180, alignment: Alignment.center)
                .foregroundColor(.black)
                .lineLimit(1)
            
        }
    }
}


struct TvShowView_Previews: PreviewProvider {
    static var previews: some View {
        TvShowView(show: TvShow(id: 12, name: "DDLJ", overview: "Boring movie", poster_path: ""))
    }
}
