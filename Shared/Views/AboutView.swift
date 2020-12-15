//
//  AboutView.swift
//  BlackjackCounting (iOS)
//
//  Created by 築山朋紀 on 2020/12/13.
//

import SwiftUI
import ComposableArchitecture

struct AboutState: Equatable {
    let applicationReviewUrl = URL(string: "https://apps.apple.com/jp/app/id1544949227?mt=8&action=write-review")!
    let developerTwitterUrl = URL(string: "https://twitter.com/tomoki_sun")!
    let privacyPolicyUrl = URL(string: "https://twitter.com/tomoki_sun")!
    let openSourceSoftwareUrl = URL(string: "http://github.com/tomoki69386/BlackjackCounting")!
    
    let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    
    var displayApplicationVerstion: String {
        return "\(versionNumber)(\(buildNumber))"
    }
}

enum AboutAction: Equatable {
    
}

struct AboutEnvironment {
    
}

let aboutReducer = Reducer<AboutState, AboutAction, AboutEnvironment> { state, action, _ in
    
    .none
}

struct AboutView: View {
    
    let store: Store<AboutState, AboutAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section {
                    Link("Review the app", destination: viewStore.applicationReviewUrl)
                        .foregroundColor(.primary)
                    
                    Link("Developer", destination: viewStore.developerTwitterUrl)
                        .foregroundColor(.primary)
                    
                    Link("Privacy Policy", destination: viewStore.privacyPolicyUrl)
                        .foregroundColor(.primary)
                    
                    Link("open source software", destination: viewStore.openSourceSoftwareUrl)
                        .foregroundColor(.primary)
                }
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(viewStore.displayApplicationVerstion)
                            .foregroundColor(.secondary)
                    }
                }
                Section {
                    NavigationLink(
                        destination: QuestionView(
                            store: .init(
                                initialState: .init(),
                                reducer: questionReducer,
                                environment: .init()
                            )
                        ),
                        label: {
                            Text("カウンティングとは")
                                .foregroundColor(.primary)
                                .font(.body)
                        })
                }
            }
            .navigationTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(
            store: .init(
                initialState: .init(),
                reducer: aboutReducer,
                environment: .init()
            )
        )
    }
}
