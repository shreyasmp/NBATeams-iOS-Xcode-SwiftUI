//
//  NBATeamsViewModelTests.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/18/25.
//

import XCTest
import Combine
@testable import NBATeams

class NBATeamsViewModelTests: XCTestCase {

    var viewModel: NBATeamsViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchNBATeamsSuccess() {
        let expectation = self.expectation(description: "Fetch NBA Teams Success")

        // Mock the service to return a successful response
        let mockService = MockNBATeamService()
        mockService.teams = [Team(id: 1, full_name: "Team A", wins: 10, losses: 5, players: [])]
        viewModel = NBATeamsViewModel(service: mockService)

        viewModel.$teams
            .dropFirst()
            .sink { teams in
                XCTAssertEqual(teams.count, 1)
                XCTAssertEqual(teams.first?.full_name, "Team A")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchNBATeams()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchNBATeamsFailure() {
        let expectation = self.expectation(description: "Fetch NBA Teams Failure")

        // Mock the service to return a failure response
        let mockService = MockNBATeamService()
        mockService.error = URLError(.badServerResponse)
        viewModel = NBATeamsViewModel(service: mockService)

        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if errorMessage != nil {
                    XCTAssertEqual(errorMessage, "Error fetching teams: The operation couldn’t be completed. (NSURLErrorDomain error -1011.)")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchNBATeams()

        waitForExpectations(timeout: 5, handler: nil)
    }
}
