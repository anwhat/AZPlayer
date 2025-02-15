//
//  ContentView.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

import AVKit
import SwiftUI

struct VideosListView: View {
    @StateObject var viewModel = VideosListViewModel()
    @Environment(Router.self) private var router

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

struct VideoDetail: View {
    private var url = URL(string: "https://cdndirector.dailymotion.com/cdn/manifest/video/x9dupaw.m3u8?sec=i-met_Mjq_g59j4DfrrkfmNQxRMv9TzhFnlqyQtvywpt2DNjyd9RRAuhK1gY-xf_X_kLUREhgt671s7OfFHeGg&dmTs=643994&dmV1st=0950cc51-80e3-f6f2-f769-ac3ed8c2bb98")!
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: url))
            .edgesIgnoringSafeArea(.all)
    }
    
}

#Preview {
    VideosListView()
        .environment(Router())
}
