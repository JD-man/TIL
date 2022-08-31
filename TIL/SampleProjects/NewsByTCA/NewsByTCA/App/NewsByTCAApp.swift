//
//  NewsByTCAApp.swift
//  NewsByTCA
//
//  Created by 조동현 on 2022/08/30.
//

import SwiftUI

@main
struct NewsByTCAApp: App {
    var body: some Scene {
        WindowGroup {
            NewsViewBuilder.news.view
        }
    }
}
