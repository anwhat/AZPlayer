//
//  AZPlayerApp.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

import SwiftUI
import SwiftData

@main
struct AZPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            VideosListView()
                .environment(Router())
        }
    }
}
