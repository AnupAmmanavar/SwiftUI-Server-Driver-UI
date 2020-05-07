//
//  TmDbRepository.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

let apiKey = "api_key=02e40a2424558958a9d91847362b03ae"

protocol TmdbRepository {

    func getPopularMovies() -> Observable<MoviesResult>

    func getPopularTvShows() -> Observable<TvShowsResult>

    func getGenreList() -> Observable<GenreResult>

    func getLanguages() -> Observable<[Language]>
}

class TmDbRepositoryImpl : BaseRepository, TmdbRepository {

    func getPopularMovies() -> Observable<MoviesResult> {
        return super.createRequest(url: "https://api.themoviedb.org/3/movie/popular?\(apiKey)")
    }

    func getPopularTvShows() -> Observable<TvShowsResult> {
        super.createRequest(url: "https://api.themoviedb.org/3/tv/popular?\(apiKey)")
    }

    func getGenreList() -> Observable<GenreResult> {
        return super.createRequest(url: "https://api.themoviedb.org/3/genre/movie/list?\(apiKey)")
    }

    func getLanguages() -> Observable<[Language]> {
        return super.createRequest(url: "https://api.themoviedb.org/3/configuration/languages?\(apiKey)")
    }

}
