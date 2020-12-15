//
//  RootView.swift
//  BlackjackCounting (iOS)
//
//  Created by 築山朋紀 on 2020/12/12.
//

import SwiftUI
import ComposableArchitecture

struct RootState: Equatable {
    var counter = CounterState()
    var about = AboutState()
}

enum RootAction: Equatable {
    case counter(CounterAction)
    case about(AboutAction)
    
    case onAppear
    case tappedInfoButton
}

struct RootEnvironment {
    
}

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    .init { state, action, _ in
        switch action {
        case .onAppear:
            state = .init()
            return .none
        default:
            return .none
        }
    },
    counterReducer.pullback(
        state: \.counter,
        action: /RootAction.counter,
        environment: { _ in .init() }
    ),
    aboutReducer.pullback(
        state: \.about,
        action: /RootAction.about,
        environment: { _ in .init() }
    )
)

struct RootView: View {
    let store: Store<RootState, RootAction>
    var body: some View {
        WithViewStore(self.store.stateless) { viewStore in
            NavigationView {
                CounterView(
                    store: self.store.scope(
                        state: { $0.counter },
                        action: RootAction.counter
                    )
                )
                .navigationBarItems(
                    trailing: NavigationLink(
                        destination: AboutView(
                            store: self.store.scope(
                                state: { $0.about },
                                action: RootAction.about
                            )
                        ),
                        label: {
                            Image(systemName: "person.crop.circle")
                                .font(.title)
                        })
                )
            }
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: RootState(),
                reducer: rootReducer,
                environment: RootEnvironment()
            )
        )
    }
}
