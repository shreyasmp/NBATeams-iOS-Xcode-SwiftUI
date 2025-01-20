//
//  NBATeamService.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/16/25.
//

import Foundation
import Combine

class NBATeamService {
    
    private let baseURL = "https://raw.githubusercontent.com/shreyasmp/RxJavaBeginner/master/input.json"
    
    func fetchNBATeams() -> AnyPublisher<[Team], Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TeamsResponse.self, decoder: JSONDecoder())
            .map { $0.teams }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
