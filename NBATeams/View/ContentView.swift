//
//  ContentView.swift
//  NBATeams
//
//  Created by Shreyas Muthkur on 1/16/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = NBATeamsViewModel(service: NBATeamServiceImpl())
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(viewModel.teams) { team in
                        NavigationLink(destination: TeamDetailView(team: team)) {
                            VStack(alignment:. leading) {
                                Text(team.full_name)
                                    .font(.headline)
                                HStack {
                                    Text("Wins: \(team.wins)")
                                        .font(.subheadline)
                                    Text("Losses: \(team.losses)")
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("NBA Teams")
            .onAppear {
                viewModel.fetchNBATeams()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}

struct Previews_ContentView_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/)
    }
}
