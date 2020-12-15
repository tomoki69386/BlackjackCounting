//
//  ResetButton.swift
//  BlackjackCounting (iOS)
//
//  Created by 築山朋紀 on 2020/12/12.
//

import SwiftUI

struct ResetButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("Reset")
                .font(.callout)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .foregroundColor(.blue)
        })
        .frame(height: 26)
        .cornerRadius(16)
    }
}

struct ResetButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetButton {
            
        }
        .previewLayout(.sizeThatFits)
    }
}
