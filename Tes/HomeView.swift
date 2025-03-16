//
//  ContentView.swift
//  FoodVisionAI
//
//  Created by ANDISAPUTRA on 03/03/25.
//

import SwiftUI

struct Performer: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let score: Int
    let image: String
    let isIncreasing: Bool
}

struct PerformerSeiton: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let score: Int
    let image: String
}

struct HomeView: View {
    // Define 3 columns
    let rows = [
        GridItem(.flexible()), // First column
        GridItem(.flexible()), // Second column
        GridItem(.flexible())  // Third column
    ]
    
    @State private var userName: String = "User" // Default value
    @State private var profilePhoto: String = "User" // Default value
    @State private var pointsGeneral: Int = 0 // Default value
    @State private var performers: [Performer] = []
    @State private var performerSeiton: [PerformerSeiton] = []
    
    var body: some View {
        ScrollView {
            VStack (spacing: 40) {
                HStack(spacing: 10) {
                    AsyncImage(url: URL(string: profilePhoto)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView() // Placeholder loading
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "person.circle.fill") // Placeholder jika gagal
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }

                    VStack(alignment: .leading) {
                        Text("Hello, \(userName)!") // Nama user dari UserDefaults
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("Your Dashboard")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Color.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onAppear {
                    fetchPerformers()
                    loadUserData() // Load user data saat tampilan muncul
                    fetchSeitonPerformers()
                }
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Today's Performance")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    HStack{
                        PerformanceItem(icon: "chart.bar", value: "200", label: "Steps")
                        PerformanceItem(icon: "clock", value: "200", label: "Time")
                        PerformanceItem(icon: "star.circle", value: (String(pointsGeneral)), label: "Points")
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Top Performers")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    VStack(alignment: .leading){
                        ForEach(performers) { performer in
                            PerformerItem(performer: performer)
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Sipaling Rapi")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    VStack(alignment: .leading){
                        ForEach(performerSeiton) { performer in
                            SeitonItem(performer: performer)
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
    }
    
    private func loadUserData() {
        if let userDataString = UserDefaults.standard.string(forKey: "userData"),
           let data = userDataString.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let dataDict = jsonObject["data"] as? [String: Any],  // Cast "data" ke dictionary
           let userDict = dataDict["user"] as? [String: Any] {    // Cast "user" ke dictionary
            
            if let name = userDict["name"] as? String {
                userName = name // Set nama user dari JSON
            }
            
            if let photo = userDict["profilePhoto"] as? String {
                profilePhoto = photo // Set foto profil dari JSON
            }
            
            if let pointsGeneralAPI = userDict["points"] as? Int {
                pointsGeneral = pointsGeneralAPI // Set foto profil dari JSON
            }
        }
    }
    
    private func fetchPerformers() {
            guard let url = URL(string: "https://kolab-center-api.laravel.cloud/api/ranking") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let dataDict = jsonResponse?["data"] as? [String: Any],
                           let ranking = dataDict["ranking"] as? [[String: Any]] {
                            
                            DispatchQueue.main.async {
                                self.performers = ranking.enumerated().map { index, item in
                                    Performer(
                                        rank: index + 1,
                                        name: item["name"] as? String ?? "Unknown",
                                        score: item["points"] as? Int ?? 0,
                                        image: item["profilePhoto"] as? String ?? "",
                                        isIncreasing: Bool.random()
                                    )
                                }
                            }
                        }
                    } catch {
                        print("Failed to parse JSON: \(error)")
                    }
                }
            }.resume()
        }
    
    private func fetchSeitonPerformers() {
            guard let url = URL(string: "https://kolab-center-api.laravel.cloud/api/seiton/rank") else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                do {
                    let result = try JSONDecoder().decode(RankingResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.performerSeiton = result.data.ranking.enumerated().map { index, item in
                            PerformerSeiton(rank: index + 1, name: item.user.name, score: item.total_score, image: item.user.profilePhoto)
                        }
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }.resume()
        }
}

struct RankingResponse: Codable {
    let data: RankingData
}

struct RankingData: Codable {
    let ranking: [RankingItem]
}

struct RankingItem: Codable {
    let user_id: Int
    let total_score: Int
    let user: User
}

struct User: Codable {
    let id: Int
    let name: String
    let profilePhoto: String
}

struct PerformanceItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack (spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .font(.title3)
            VStack {
                Text(value)
                    .font(.title2)
                    .bold()
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.orange.opacity(0.2))
        .cornerRadius(12)
    }
}

struct PerformerItem: View {
    let performer: Performer
    
    var body: some View {
        HStack (spacing: 20) {
            Text("\(performer.rank)")
                .font(.caption)
                .foregroundColor(.black)
                .frame(width: 10)
            
            HStack (spacing: 10) {
                AsyncImage(url: URL(string: performer.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                Text(performer.name)
                    .font(.callout)
                    .foregroundColor(.black)
            }
            Spacer()
            Text("\(performer.score)" + " pts")
                .font(.caption)
                .bold()
                .foregroundColor(.orange)
                .frame(width: 50)
        }
    }
}


struct SeitonItem: View {
    let performer: PerformerSeiton
    
    var body: some View {
        HStack (spacing: 20) {
            Text("\(performer.rank)")
                .font(.caption)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .frame(width: 10)
            
            HStack (spacing: 10) {
                AsyncImage(url: URL(string: performer.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                Text(performer.name)
                    .font(.callout)
                    .foregroundColor(.black)
                
            }
            
            Spacer()
            
            Text("\(performer.score) Pts")
                .font(.caption)
                .multilineTextAlignment(.leading)
                .bold()
                .foregroundColor(.orange)
                .frame(width: 50)
        }
    }
}

#Preview {
    HomeView()
}
