//
//  ContentView.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

import AVKit
import SwiftUI

struct VideosListView: View {
    @StateObject var viewModel: VideosListViewModel
    @Environment(Router.self) private var router

    init(viewModel: VideosListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        /// required to bind the routes array to the NavigationStack
        @Bindable var router = router

        NavigationStack(path: $router.routes) {
            List(viewModel.videos) { video in
                Button {
                    router.routes.append(.player(video))
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: video.thumbnailUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        Text(video.title)
                            .foregroundStyle(Color.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.primary)
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                router.destination(for: route)
            }

            .navigationTitle("Videos")
        }
        .task {
            await viewModel.fetchVideos()
        }
    }
}

#Preview {
    VideosListView(viewModel: VideosListViewModel())
        .environment(Router())
}
