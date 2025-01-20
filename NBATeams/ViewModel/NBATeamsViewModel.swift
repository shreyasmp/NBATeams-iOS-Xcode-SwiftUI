//
//  NBATeamsViewModel.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/16/25.
//

import Foundation
import Combine

class NBATeamsViewModel: ObservableObject {
    
    @Published var teams = [Team]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let service: NBATeamService
    
    init(service: NBATeamService) {
        self.service = service
    }
    
    func fetchNBATeams() {
        isLoading = true
        errorMessage = nil
        service.fetchNBATeams()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        if self.errorMessage == nil {
                            self.errorMessage = "Error fetching teams: \(error.localizedDescription)"
                            print("Error fetching teams: \(error.localizedDescription)")
                        }
                }
            }, receiveValue: { [weak self] teams in
                self?.teams = teams
            })
            .store(in: &cancellables)
    }
}
