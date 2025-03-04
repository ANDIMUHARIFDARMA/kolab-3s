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

struct Seiso: View {
    // Define 3 columns
    let rows = [
        GridItem(.flexible()), // First column
        GridItem(.flexible()), // Second column
        GridItem(.flexible())  // Third column
    ]
    
    var body: some View {
        let performers: [Performer] = [
                Performer(rank: 1, name: "Sarah Johnson", score: 2840, image: "Gambar", isIncreasing: true),
                Performer(rank: 2, name: "Michael Chen", score: 2720, image: "Gambar", isIncreasing: false),
                Performer(rank: 3, name: "Emily Davis", score: 2650, image: "Gambar", isIncreasing: true),
                Performer(rank: 4, name: "David Kim", score: 2580, image: "Gambar", isIncreasing: false),
                Performer(rank: 5, name: "Lisa Wang", score: 500, image: "Gambar", isIncreasing: true)
        ]
        
        ScrollView{
            VStack (spacing: 40) {
                HStack(spacing: 16) {
                    Image("Gambar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Hello, Alex!").font(.title).fontWeight(.bold)
                        Text("Your Dashboard").font(.subheadline).multilineTextAlignment(.leading).foregroundStyle(Color.gray)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).padding()
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Today's Performance")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    HStack{
                        PerformanceItem(icon: "chart.bar", value: "200", label: "Steps")
                        PerformanceItem(icon: "clock", value: "200", label: "Time")
                        PerformanceItem(icon: "star.circle", value: "200", label: "Points")
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).padding()
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Top Performers")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                    VStack(alignment: .leading){
                        ForEach(performers) { performer in
                            PerformerItem(performer: performer)
                        }
                    }.frame(width: .infinity)
                }.frame(maxWidth: .infinity, alignment: .leading).padding()
            }
        }
    }
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
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
                .frame(width: 10)
                
            HStack {
                Image(performer.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                Text(performer.name)
                    .font(.body)
                    .foregroundColor(.black)

            }
            
            Spacer()
            
            Text("\(performer.score)")
                .font(.body)
                .multilineTextAlignment(.leading)
                .bold()
                .foregroundColor(.orange)
                .frame(width: 50)
            
            Image(systemName: performer.isIncreasing ? "arrow.up.right" : "arrow.down.right")
                .foregroundColor(performer.isIncreasing ? .green : .red)
        }
        .padding(.horizontal)
        .frame(width: .infinity)
    }
}

#Preview {
    Seiso()
}
