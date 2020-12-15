//
//  CounterView.swift
//  BlackjackCounting (iOS)
//
//  Created by 築山朋紀 on 2020/12/12.
//

import SwiftUI
import PokerHands
import ComposableArchitecture

struct CounterState: Equatable {
    var alert: AlertState<CounterAction>?
    var count = 0
    var displayCount: String {
        return String(count)
    }
    
    var incrementNumbers: [Number] {
        return [.ten, .eleven, .twelve, .thirteen, .one]
    }
    
    var decrementNumbers: [Number] {
        return [.two, .three, .four, .five, .six]
    }
}

enum CounterAction: Equatable {
    case tappedIncrementButton
    case tappedDecrementButton
    case tappedResetCountButton
    case alertDismissed
    case acceptResetting
    case cancelResetting
}

struct CounterEnvironment {
    
}

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, _ in
    
    switch action {
    case .tappedIncrementButton:
        state.count += 1
        return .none
    case .tappedDecrementButton:
        state.count -= 1
        return .none
    case .tappedResetCountButton:
        state.alert = .init(
            title: "カウンティングをリセットしますか？",
            primaryButton: .cancel(
                send: CounterAction.cancelResetting
            ),
            secondaryButton: .default("リセットする",
                send: CounterAction.acceptResetting
            )
        )
        return .none
    case .alertDismissed:
        state.alert = nil
        return .none
    case .acceptResetting:
        state.count = 0
        return .none
    case .cancelResetting:
        return .none
    }
}

struct CounterView: View {
    
    let store: Store<CounterState, CounterAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView {
                VStack {
                    Button(action: {
                        viewStore.send(.tappedDecrementButton)
                    }, label: {
                        HStack {
                            ForEach(viewStore.incrementNumbers, id: \.self) { number in
                                TrumpView(trump: Trump(suit: .clubs, number: number))
                            }
                        }
                    })
                    .padding(.top, 24)
                    Text(viewStore.displayCount)
                        .font(.largeTitle)
                        .frame(height: 150)
                    
                    Button(action: {
                        viewStore.send(.tappedIncrementButton)
                    }, label: {
                        HStack {
                            ForEach(viewStore.decrementNumbers, id: \.self) { number in
                                TrumpView(trump: Trump(suit: .clubs, number: number))
                            }
                        }
                    })
                    
                    ResetButton {
                        viewStore.send(.tappedResetCountButton)
                    }
                    .padding(.top, 50)
                    .alert(self.store.scope(state: { $0.alert }), dismiss: .alertDismissed)
                }
            }
            .navigationTitle("Counting")
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: .init(
                initialState: .init(),
                reducer: counterReducer,
                environment: .init()
            )
        )
    }
}
