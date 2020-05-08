//
//  SubscriptionComponent.swift
//  SwiftUI-SDUI
//
//  Created by porter on 07/05/20.
//  Copyright © 2020 kinley. All rights reserved.
//

import Foundation
import SwiftUI

struct NotificationComponent: UIComponent {
    var uniqueId: String
    
    let uiModel: NotificationUIModel
    
    func render(uiDelegate: UIDelegate) -> AnyView {
        NotificationView(component: self, uiDelegate: uiDelegate as! NotificationDelegate, uiModel: uiModel).toAny()
    }
}


struct NotificationView: View {
    
    let component: NotificationComponent
    let uiDelegate: NotificationDelegate
    let uiModel: NotificationUIModel
    
    var body: some View {
        
        VStack {
            HStack {
                Text(uiModel.header)
                    .font(.title)
                    .frame(alignment: Alignment.leading)
                
                Spacer()
                
                Text("Cancel")
                    .font(.headline)
                    .foregroundColor(.red)
                    .onTapGesture {
                        self.uiDelegate.cancelClick(identifier: self.component.uniqueId)
                }
            }
            
            HStack {
                Text(uiModel.message)
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action: {
                    self.uiDelegate.actionClick()
                }) {
                    Text(uiModel.actionText)
                }
            }
        }
        .padding()
        .background(Color(red: 0.65, green: 0.4, blue: 0.2, opacity: 0.2))
    }
}

struct NotificationUIModel {
    let header: String
    let message: String
    let actionText: String
}

class ProxyUIDelegate : UIDelegate {}

protocol NotificationDelegate: UIDelegate {
    func cancelClick(identifier: String)
    
    func actionClick()
}
