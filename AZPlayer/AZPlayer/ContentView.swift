//
//  ContentView.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

import AVKit
import SwiftUI

struct ContentView: View {

    @StateObject var api = VideoAPI()

    var body: some View {
        NavigationView {
            List(api.videos) { video in
                NavigationLink(destination: VideoDetail()) {
                    // Load thumbnail
                    AsyncImage(url: URL(string: video.thumbnail_url)) { status in
                        if let image = status.image {
                            image.resizable()
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 80, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text(video.title)
                }
            }
            .onAppear {
                Task {
                    await api.fetchList()
                }
            }
            .navigationTitle("Videos")
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
    ContentView()
}
