//
//  UIComponent.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import SwiftUI


protocol UIDelegate {}

protocol UIComponent {
    var uniqueId: String  { get }
    func render(uiDelegate: UIDelegate) -> AnyView
}
