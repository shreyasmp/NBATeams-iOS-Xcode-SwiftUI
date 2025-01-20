//
//  TeamDetailView.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/16/25.
//

import SwiftUI

struct TeamDetailView: View {
    let team: Team
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Wins: \(team.wins)")
                    .font(.title2)
                Text("Losses: \(team.losses)")
                    .font(.title2)
            }
            .padding(.bottom, 10)
            List(team.players) { player in
                VStack(alignment: .leading) {
                    Text("\(player.first_name) \(player.last_name)")
                        .font(.headline)
                    Text("Position: \(player.position)")
                        .font(.subheadline)
                    }
                    .padding(.vertical, 5)
                }
                Spacer()
        }
        .padding()
        .navigationTitle(team.full_name)
    }
}
