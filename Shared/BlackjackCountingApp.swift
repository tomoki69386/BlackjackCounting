//
//  BlackjackCountingApp.swift
//  Shared
//
//  Created by 築山朋紀 on 2020/12/12.
//

import SwiftUI
import ComposableArchitecture

@main
struct BlackjackCountingApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: RootState(),
                    reducer: rootReducer,
                    environment: RootEnvironment()
                )
            )
        }
    }
}
