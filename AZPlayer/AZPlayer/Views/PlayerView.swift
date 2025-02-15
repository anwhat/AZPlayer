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
                                viewModel.isPlaying = false
                            }
                    }
                    .onDisappear {
                        player.pause()
                        NotificationCenter.default.removeObserver(self)
                    }
                    .overlay(
                        Group {
                            if !viewModel.isPlaying {
                                Button {
                                    player.play()
                                    viewModel.isPlaying = true
                                } label: {
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

                player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { time in
                    guard let item = self.player?.currentItem else {
                        return
                    }
                    self.viewModel.seekPosition = time.seconds / item.duration.seconds
                }
            }
        }
        .task {
            await viewModel.fetchMetadata()
        }

        Slider(
            value: $viewModel.seekPosition,
            in: 0.0...1.0,
            onEditingChanged: { _ in
                guard let item = self.player?.currentItem else {
                    return
                }
                let targetTime = self.viewModel.seekPosition * item.duration.seconds
                self.player?.seek(to: CMTime(seconds: targetTime, preferredTimescale: 600))
            }
        )
    }
}
