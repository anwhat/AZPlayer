//
//  PlayerView.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

import AVKit
import SwiftUI

struct PlayerView: View {
    @StateObject private var viewModel: PlayerViewModel
    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false

    init(viewModel: PlayerViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            if let player = player {
                VideoPlayer(player: player)
                    .aspectRatio(16/9, contentMode: .fit)
                    .onAppear {
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main) { _ in
                                player.seek(to: .zero)
                                player.pause()
                                isPlaying = false
                            }
                    }
                    .onDisappear {
                        player.pause()
                        NotificationCenter.default.removeObserver(self)
                    }
                    .overlay(
                        Group {
                            if !isPlaying {
                                Button(action: {
                                    player.play()
                                    isPlaying = true
                                }) {
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.white)
                                        .opacity(0.8)
                                }
                            }
                        }
                    )
            } else {
                ProgressView()
            }
        }
        .onReceive(viewModel.$videoURL) { url in
            if let url = URL(string: url) {
                player = AVPlayer(url: url)
            }
        }
        .task {
            await viewModel.fetchMetadata()
        }
    }
}
