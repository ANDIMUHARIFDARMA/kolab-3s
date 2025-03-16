import SwiftUI

struct BottomNavBar: View {
        @State private var selectedTab: Int = 0 // Menyimpan tab yang aktif

        var body: some View {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.circle.fill" : "house.circle")
                        Text("Home")
                    }
                    .tag(0)

                SeiriView()
                    .tabItem {
                        Image(systemName: selectedTab == 1 ? "fork.knife.circle.fill" : "fork.knife.circle")
                        Text("Seiri")
                    }
                    .tag(1)
                
                ShitsukeView()
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "calendar.badge.clock" : "calendar.badge.clock")
                        Text("Shitsuke")
                    }
                    .tag(2)

                SeitonView()
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "face.dashed.fill" : "face.dashed")
                        Text("Seiton")
                    }
                    .tag(3)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: selectedTab == 4 ? "person.circle.fill" : "person.circle")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .accentColor(Color(hue: 0.076, saturation: 1.0, brightness: 0.854)) // Warna icon saat tab aktif
        }
    }

struct ProfileView: View {
    var body: some View {
        PrimaryButton(title: "Logout", action: {
            UserDefaults.standard.removeObject(forKey: "userToken")
            UserDefaults.standard.removeObject(forKey: "userData")
        })
    }
}

// Preview
struct BottomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavBar()
    }
}
