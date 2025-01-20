//
//  NBATeamService.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/19/25.
//

import Combine

protocol NBATeamService {
    func fetchNBATeams() -> AnyPublisher<[Team], Error>
}
