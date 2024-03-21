//
//  MatchesView.swift
//  BallyLiveForVisionOS
//
//  Created by Rafael Quixabeira on 18/03/24.
//  Copyright © 2024 Bally's Corporation. All rights reserved.
//

import Foundation
import SwiftUI

struct MatchesView: View {
    @Binding
    public var games: [Game]
    
    public var onTap: (Int) -> Void
    
    var body: some View {
        VStack {
            Text("Triple A")
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white.opacity(0.23))
                .padding(EdgeInsets(
                    top: 12.0, leading: 28.0, bottom: .zero, trailing: 28.0
                ))
            List {
                ForEach(games.indices, id: \.self) { index in
                    let game = $games[index]

                    MatchItemView(game: game)
                        .padding(.vertical, 8.0)
                        .padding(.horizontal, 12.0)
                        .listRowInsets(EdgeInsets())
                        .background(game.selected.wrappedValue ? Color(red: 0.37, green: 0.37, blue: 0.37).opacity(0.18) : .clear)
                        .background(game.selected.wrappedValue ? .white.opacity(0.07) : .clear)
                        .cornerRadius(16.0)
                        .onTapGesture {
                            onTap(index)
                        }
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
    }
}

struct MatchItemView: View {
    @Binding
    var game: Game
    
    var teams: [Team] {
        [
            game.homeTeam,
            game.awayTeam
        ].compactMap {
            $0
        }
    }
    
    var homeTeam: Team? {
        game.homeTeam
    }
    
    var awayTeam: Team? {
        game.awayTeam
    }
    
    var inningResume: String? {
        guard
            let inning = game.inning,
            let half = inning.inningHalf,
            let current = inning.currentInning
        else { return nil }
        
        return "\(half) \(current)"
    }
    
    var body: some View {
        HStack(spacing: 16.0) {
            VStack(spacing: 4.0) {
                HStack(spacing: 8.0) {
                    AsyncImage(url: homeTeam?.logoSMURL)
                        .frame(width: 14.0, height: 14.0)
                        .clipShape(.capsule)
                    
                    if let name = homeTeam?.name {
                        Text(name)
                            .font(.system(size: 15.0))
                            .foregroundColor(.white.opacity(0.96))
                            .frame(alignment: .leading)
                    }
                    
                    if let leagueRecordsResume = homeTeam?.leagueRecordsResume {
                        Text(leagueRecordsResume)
                            .font(.system(size: 12.0).weight(.medium))
                            .foregroundColor(.white.opacity(0.23))
                        Spacer()
                    } else {
                        Spacer()
                    }
                    
                    Text(homeTeam?.score ?? "-")
                        .font(.system(size: 15.0))
                        .foregroundColor(.white.opacity(0.96))
                }.frame(maxWidth: .infinity)
                HStack(spacing: 8.0) {
                    AsyncImage(url: awayTeam?.logoSMURL)
                        .frame(width: 14.0, height: 14.0)
                        .clipShape(.capsule)
                    
                    if let name = awayTeam?.name {
                        Text(name)
                            .font(.system(size: 15.0))
                            .foregroundColor(.white.opacity(0.96))
                            .frame(alignment: .leading)
                    }
                    
                    if let leagueRecordsResume = awayTeam?.leagueRecordsResume {
                        Text(leagueRecordsResume)
                            .font(.system(size: 12.0).weight(.medium))
                            .foregroundColor(.white.opacity(0.23))
                        Spacer()
                    } else {
                        Spacer()
                    }
                    
                    Text(awayTeam?.score ?? "-")
                        .font(.system(size: 15.0))
                        .foregroundColor(.white.opacity(0.96))
                }.frame(maxWidth: .infinity)
            }.frame(minHeight: 44.0)
            VStack(alignment: .trailing, spacing: 4.0) {
                if let inningResume {
                    Text(inningResume)
                        .font(.system(size: 11.0).weight(.semibold))
                        .foregroundColor(.white.opacity(0.96))
                }
                if let status = game.status {
                    HStack(alignment: .center, spacing: 4) {
                        Text(status)
                            .font(.system(size: 10).weight(.bold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.red)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .inset(by: 0.5)
                            .stroke(
                                LinearGradient(gradient: Gradient(colors: [
                                    Color(red: 1, green: 1, blue: 1, opacity: 0.4),
                                    Color(red: 1, green: 1, blue: 1, opacity: 0),
                                    Color(red: 1, green: 1, blue: 1, opacity: 0),
                                    Color(red: 1, green: 1, blue: 1, opacity: 0.1)
                                ]), startPoint: .topLeading, endPoint: .bottomTrailing),
                                lineWidth: 1
                            )
                    )
                    
                }
            }.frame(minWidth: 104.0, minHeight: 44.0, alignment: .trailing) // stack #02
        }.padding(.vertical, 4.0)
    }
}
