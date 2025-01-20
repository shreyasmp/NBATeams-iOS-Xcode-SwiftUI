//
//  Team.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/16/25.
//

import Foundation

struct Team: Identifiable, Codable {
    let id: Int
    let full_name: String
    let wins: Int
    let losses: Int
    let players: [Player]
}
