//
//  MILBViewModel.swift
//  BallyLiveForVisionOS
//
//  Created by Rafael Quixabeira on 18/03/24.
//  Copyright © 2024 Bally's Corporation. All rights reserved.
//

import Foundation
import Combine
import AVKit

class MILBViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    @Published
    public var currentLivestreamURL: URL?

    @Published
    public var games: [Game] = []

    public func fetch() async {
        guard
            let data = await Worker.shared.fetchMILBSchedule(startDate: .now, endDate: .now)
        else { return }

        await MainActor.run {
            if let game = data.games.first, let cndURL = game.publicCDNURL, let url = URL(string: cndURL) {
                game.selected = true
                self.currentLivestreamURL = url
            }

            self.games = data.games
        }
    }

    public func onSelectedGameIndex(index: Int) {
        guard
            let publicCDNURL = games[index].publicCDNURL,
            let url = URL(string: publicCDNURL)
        else { return }

        Task {
            await MainActor.run {
                self.games.forEach { $0.selected = false }
                self.games[index].selected = true
                self.games = self.games
                self.currentLivestreamURL = url
            }
        }
    }
}
