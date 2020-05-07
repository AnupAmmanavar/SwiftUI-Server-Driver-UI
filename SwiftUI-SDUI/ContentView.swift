//
//  ContentView.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import SwiftUI

struct ContentView: View, UIDelegate {

    @ObservedObject
    var controller: HomePageController

    var body: some View {

        renderPage(ui: controller.uiComponents, uiDelegate: self)
            .onAppear(perform: {
                self.controller.loadPage()
            })
            .background(SwiftUI.Color.gray.edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(controller: HomePageController())
    }
}
