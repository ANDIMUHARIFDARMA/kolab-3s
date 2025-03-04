import SwiftUI

struct BottomNavBar: View {
        @State private var selectedTab: Int = 0 // Menyimpan tab yang aktif

        var body: some View {
            TabView(selection: $selectedTab) {
                Seiso()
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.circle.fill" : "house.circle")
                        Text("Home")
                    }
                    .tag(0)

                SearchView()
                    .tabItem {
                        Image(systemName: selectedTab == 1 ? "fork.knife.circle.fill" : "fork.knife.circle")
                        Text("Seiri")
                    }
                    .tag(1)

                ContentView()
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "face.dashed.fill" : "face.dashed")
                        Text("Seiton")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "person.circle.fill" : "person.circle")
                        Text("Profile")
                    }
                    .tag(3)
            }
            .accentColor(Color(hue: 0.076, saturation: 1.0, brightness: 0.854)) // Warna icon saat tab aktif
        }
    }

// Sample Views
struct HomeView: View {
    var body: some View {
        Text("Home Screen")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct SearchView: View {
    var body: some View {
        Text("Search Screen")
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile Screen")
            .font(.largeTitle)
            .foregroundColor(.purple)
    }
}

// Preview
struct BottomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavBar()
    }
}
