//
//  MoviesResult.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation

struct MoviesResult: Codable {
    var results: [Movie]
    let title: String?
}


struct Movie: Codable, Hashable {
    var id: CLong
    var title: String
    var overview: String
    var poster_path: String
}
