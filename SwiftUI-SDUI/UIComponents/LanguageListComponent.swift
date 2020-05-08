//
//  LanguageListComponent.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import SwiftUI


struct LanguageListComponent : UIComponent {
    
    let languages: [Language]
    var uniqueId: String = ""
    
    func render(uiDelegate: UIDelegate) -> AnyView {
        LanguageListView(languages: languages).toAny()
    }
    
}

struct LanguageListView: View {
    
    let languages: [Language]
    
    var body: some View {
        VStack {
            HStack {
                Text("Languages")
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(languages, id: \.id) { language in
                        LanguageView(language: language)
                    }
                }
            }
        }
        .padding()
    }
}

struct LanguageView: View {
    let language: Language
    var body: some View {
        VStack {
            Text(language.englishName)
                .font(.subheadline)
                .foregroundColor(Color.white)
                .padding(.all)
                .background(Color.gray)
                .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 2)
            
        }
    }
}

struct LanguageView_Preview: PreviewProvider {
    static var previews: some View {
        LanguageView(language: Language(id: "en", englishName: "English", name: "English"))
            .background(SwiftUI.Color.gray.edgesIgnoringSafeArea(.all))
    }
    
}
