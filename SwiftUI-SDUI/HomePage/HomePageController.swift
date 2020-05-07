//
//  HomePageController.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import RxSwift


class HomePageController: ObservableObject {

    @Published
    var uiComponents: [UIComponent] = []

    let disposableBag = DisposeBag()

    let repository: TmdbRepository = TmDbRepositoryImpl()

    func loadPage() {
        uiComponents = []
        Observable
            .zip(repository.getPopularMovies(), repository.getPopularTvShows(), repository.getGenreList(), repository.getLanguages(),
                 resultSelector: { (movieResult, tvShowsResult, genresResult, languages) in
                    var components: [UIComponent] = []

                    components.append(NotificationComponent(uniqueId: "Subsciption", uiModel: NotificationUIModel(header: "Subsciption", message: "Your subscription has expired", actionText: "Renew")))
                    components.append(MovieListUIComponent(movieResult: MoviesResult(results: movieResult.results, title: "Popular Movies")))
                    components.append(TvShowsListUIComponent(tvShowsResult: tvShowsResult, id: "Popular Tv Shows"))
                    components.append(GenreListComponent(genres: genresResult.genres, uniqueId: "Genre"))
                    components.append(LanguageListComponent(languages: languages, uniqueId: "Languages"))

                    return components
            })
            .subscribe(
                onNext: { [weak self] components in
                    self?.uiComponents = components
                },
                onError: { error in
                    debugPrint(error)
            }
        )
            .disposed(by: disposableBag)

    }


    // Removes the subscriptin component
    func removeComponent(id: String) {
        uiComponents = uiComponents.filter() { component in
            component.uniqueId != id
        }
    }

}
