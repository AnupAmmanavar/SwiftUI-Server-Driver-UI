//
//  BaseRepository.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class BaseRepository {
    func createRequest<T: Codable>(url: String) -> Observable<T> {

        let observable = Observable<T>.create { observer -> Disposable in

            Alamofire.request(url)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            observer.onError(response.error ?? AppError.runtimeError("random message"))
                            return
                        }
                        do {
                            let projects = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(projects)
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
        observable
            .observeOn(MainScheduler.instance)

        return observable
    }
}

enum AppError: Error {
    case runtimeError(String)
}
