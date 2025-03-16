import SwiftUI

struct ButtomAttendce: View {
    @State private var isLoading = false
    @State private var responseMessage: String?

    var body: some View {
        VStack {
            Button(action: handleAttendance) {
                HStack {
                    if isLoading {
                        ProgressView()
                    } else {
                        Image(systemName: "clock")
                        Text("Check In")
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            if let message = responseMessage {
                Text(message)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.top, 5)
            }
        }
        .padding(.horizontal)
    }

    private func handleAttendance() {
        guard let url = URL(string: "https://kolab-center-api.laravel.cloud/api/time-in") else { return }
        
        // Ambil token dari UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            responseMessage = "Error: No token found."
            return
        }

        isLoading = true
        responseMessage = nil

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Bearer Token

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.responseMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.responseMessage = "No response from server."
                    return
                }
                
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let message = jsonResponse["message"] as? String {
                        self.responseMessage = message
                    }
                    
                    // Simpan response ke UserDefaults dengan key "defaultUser"
                    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: .prettyPrinted),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        UserDefaults.standard.set(jsonString, forKey: "userData")
                        print("User data berhasil disimpan ke UserDefaults dengan key 'defaultUser'")
                    }
                } else {
                    self.responseMessage = "Invalid response format."
                }
            }
        }.resume()
    }

}
