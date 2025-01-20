//
//  MockNBATeamService.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/18/25.
//

import Combine
@testable import NBATeams

class MockNBATeamService: NBATeamService {
    var teams: [Team]?
    var error: Error?

    func fetchNBATeams() -> AnyPublisher<[Team], Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(teams ?? [])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
