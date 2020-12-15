//
//  TrumpView.swift
//  BlackjackCounting (iOS)
//
//  Created by 築山朋紀 on 2020/12/12.
//

import SwiftUI
import PokerHands

struct TrumpView: View {
    @State var trump: Trump
    var foregroundColor: Color {
        switch trump.suit {
        case .hearts, .diamonds:
            return Color(.systemRed)
        case .clubs, .spades:
            return Color.primary
        }
    }
    
    var body: some View {
        VStack {
            Text(trump.number.string)
                .foregroundColor(foregroundColor)
                .font(.title)
            Text(trump.suit.string)
                .foregroundColor(foregroundColor)
                .font(.title)
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .background(Color(.systemGray6))
        .cornerRadius(9)
    }
}

struct TrumpView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 13), content: {
            ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
                ForEach(Trump.allCases, id: \.self) { trump in
                    TrumpView(trump: trump)
                        .colorScheme(colorScheme)
                }
            }
        })
        .frame(width: 1000)
        .previewLayout(.sizeThatFits)
    }
}
