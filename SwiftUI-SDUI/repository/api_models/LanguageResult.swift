//
//  LanguageResult.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation


struct Language : Codable {
    let id: String
    let englishName: String
    let name: String

    private enum CodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case englishName = "english_name"
        case name
    }
}
