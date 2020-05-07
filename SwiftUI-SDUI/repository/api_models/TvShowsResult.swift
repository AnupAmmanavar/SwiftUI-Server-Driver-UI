//
//  TvShowsResult.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation

struct TvShowsResult: Codable {
    var results: [TvShow]
}

struct TvShow: Codable {
    var id: CLong
    var name: String
    var overview: String
    var poster_path: String
}
