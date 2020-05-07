//
//  ContentView.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import SwiftUI

struct HomePageView: View, UIDelegate, NotificationDelegate {

    @ObservedObject
    var controller: HomePageController

    var body: some View {

        renderPage(ui: controller.uiComponents, uiDelegate: self)
            .onAppear(perform: {
                self.controller.loadPage()
            })
            .background(SwiftUI.Color.gray.edgesIgnoringSafeArea(.all))
    }

    func cancelClick(identifier: String) {
        self.controller.removeComponent(id: identifier)
    }

    func actionClick() {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(controller: HomePageController())
    }
}
