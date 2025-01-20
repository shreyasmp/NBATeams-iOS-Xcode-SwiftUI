//
//  TeamDetailViewTests.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/19/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NBATeams

extension TeamDetailView: Inspectable {}

class TeamDetailViewTests: XCTestCase {
    
    func testTeamDetailViewDisplaysCorrectData() throws {
        // Arrange
        let mockPlayers = [
            Player(id: 1, first_name: "John", last_name: "Doe", position: "Guard", number: 45),
            Player(id: 2, first_name: "Jane", last_name: "Smith", position: "Forward", number: 47)
        ]
        let mockTeam = Team(id: 1, full_name: "Team A", wins: 10, losses: 5, players: mockPlayers)
        
        let sut = TeamDetailView(team: mockTeam)

        // Act
        let inspectedView = try sut.inspect()

        // Assert
        let navigationView = try inspectedView.navigationView()
        let navigationTitle = try navigationView.find(ViewType.Text.self).string()
        XCTAssertEqual(navigationTitle, "Team A")

        let vStack = try inspectedView.vStack()
        let hStack = try vStack.hStack(0)
        let winsText = try hStack.text(0).string()
        let lossesText = try hStack.text(1).string()
        XCTAssertEqual(winsText, "Wins: 10")
        XCTAssertEqual(lossesText, "Losses: 5")

        let list = try vStack.list(1)
        let firstPlayer = try list.forEach(0).vStack(0)
        let firstPlayerName = try firstPlayer.text(0).string()
        let firstPlayerPosition = try firstPlayer.text(1).string()
        XCTAssertEqual(firstPlayerName, "John Doe")
        XCTAssertEqual(firstPlayerPosition, "Position: Guard")

        let secondPlayer = try list.forEach(1).vStack(0)
        let secondPlayerName = try secondPlayer.text(0).string()
        let secondPlayerPosition = try secondPlayer.text(1).string()
        XCTAssertEqual(secondPlayerName, "Jane Smith")
        XCTAssertEqual(secondPlayerPosition, "Position: Forward")

    }
}
