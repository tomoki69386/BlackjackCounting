//
//  QuestionView.swift
//  BlackjackCounting (iOS)
//
//  Created by 築山朋紀 on 2020/12/13.
//

import SwiftUI
import ComposableArchitecture

struct Question: Hashable {
    let text: String
    let url: URL
}

struct QuestionState: Equatable {
    var questions: [Question] {
        [
            Question(
                text: "カウンティングをマスターして堅実に攻略しよう",
                url: URL(string: "https://vegasdocs.com/blackjack/counting.html")!
            ),
            Question(
                text: "カジノも恐れるブラックジャック最強の必勝法「カードカウンティング」とは？",
                url: URL(string: "https://www.casinowired.com/counting-2/")!
            ),
            Question(
                text: "ブラックジャックの禁じ手、カードカウンティングとは？",
                url: URL(string: "https://allvideoslots.com/ja/%E3%82%AB%E3%83%BC%E3%83%89%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0/")!
            ),
            Question(
                text: "案外簡単なカードカウンティングのやり方手順",
                url: URL(string: "https://xn--jp-kh4aa8bwdc2mye8b.com/countbasic/bj194.html")!
            ),
            Question(
                text: "ブラックジャックの必勝法「カウンティング」とは？",
                url: URL(string: "https://slotsia.com/ja/game-blackjack/strategy-counting")!
            )
        ]
    }
}

enum QuestionAction: Equatable {
    case onAppear
}

struct QuestionEnvironment {
    
}

let questionReducer = Reducer<QuestionState, QuestionAction, QuestionEnvironment> { state, action, _ in
    
    switch action {
    case .onAppear:
        state = .init()
        return .none
    }
}

struct QuestionView: View {
    
    let store: Store<QuestionState, QuestionAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section {
                    ForEach(viewStore.questions, id: \.self) { question in
                        Link(question.text, destination: question.url)
                            .foregroundColor(.primary)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("カウンティングとは")
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(
            store: .init(
                initialState: .init(),
                reducer: questionReducer,
                environment: .init()
            )
        )
    }
}
