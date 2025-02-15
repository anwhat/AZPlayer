//
//  Router.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

import SwiftUI

enum Route: Hashable {
    case player(Video)
}

@Observable
class Router {
    var routes: [Route] = []

    @ViewBuilder
    func destination(for route: Route) -> some View {
        switch route {
            case let .player(video):
                routeToPlayer(video: video)
        }
    }

    @ViewBuilder
    private func routeToPlayer(video: Video) -> some View {
        PlayerView(viewModel: PlayerViewModel(video: video))
    }
}
