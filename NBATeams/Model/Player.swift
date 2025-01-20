//
//  Player.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/16/25.
//
struct Player: Identifiable, Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let position: String
    let number: Int
}
