//
//  ContentView.swift
//  BallyLiveForVisionOS
//
//  Created by Rafael Quixabeira on 13/03/24.
//  Copyright © 2024 Bally's Corporation. All rights reserved.
//

import SwiftUI
import AVKit

public struct ContentView: View {
    @ObservedObject
    private var viewModel: MILBViewModel = .init()

    @State
    private var player: AVPlayer = .init()

    public var body: some View {
        HStack {
            VStack(spacing: 12.0) {
                VStack {
                    MatchesView(games: $viewModel.games, onTap: { index in
                        viewModel.onSelectedGameIndex(index: index)
                    })
                    .padding(.top, 16.0)
                    .padding(.bottom, 16.0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
                VStack {
                    BoxView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassBackgroundEffect()
            }.frame(width: 508.0)
            HStack {
                ZStack {
                    VideoPlayer(player: player)
                }
                .frame(width: 1394.0)
                .glassBackgroundEffect()
                .onChange(of: viewModel.currentLivestreamURL, initial: false) {
                    guard let currentLivestreamURL = viewModel.currentLivestreamURL else { return }

                    player.pause()
                    player.currentItem?.cancelPendingSeeks()
                    player.currentItem?.asset.cancelLoading()
                    player.currentItem?.asset.cancelLoading()

                    player.cancelPendingPrerolls()
                    player.replaceCurrentItem(with: nil)

                    player.replaceCurrentItem(with: AVPlayerItem(url: currentLivestreamURL))
                    player.play()
                }
                VStack {
                    Spacer()
                    CrowdChatView()
                    Spacer()
                }
                .frame(width: 508.0).glassBackgroundEffect()
            }
        }
        .frame(height: 784.0)
        .task {
            await viewModel.fetch()
        }.ornament(attachmentAnchor: .scene(.top), contentAlignment: .bottom) {
            Image("bally-logo").padding(.bottom, 30.0)
        }.ornament(attachmentAnchor: .scene(.bottom), contentAlignment: .top) {
            ZStack {
                HStack {
                    Button(action: {
                        // TBD
                    }, label: {
                        Image(systemName: "macwindow.on.rectangle")
                        Text("Add another game")
                    })
                    Spacer()
                    Button(action: {
                        // TBD
                    }, label: {
                        Image(systemName: "person.line.dotted.person.fill")
                        Text("Watch Party")
                    })
                }.frame(width: 1394.0).padding()
            }
        }.ornament(attachmentAnchor: .scene(.bottom)) {
            VStack {
                Text("TBD").font(.extraLargeTitle)
                Text("Score").font(.title)
            }.frame(
                width: 360.0,
                height: 144.0
            ).glassBackgroundEffect().padding()
        }
    }
}

struct CrowdChatView: View {
    var body: some View {
        VStack {
            Text("TBD").font(.extraLargeTitle)
            Text("Crowd Chat").font(.title)
        }
    }
}

struct BoxView: View {
    var body: some View {
        VStack {
            Text("TBD").font(.extraLargeTitle)
            Text("Box").font(.title)
        }
    }
}
