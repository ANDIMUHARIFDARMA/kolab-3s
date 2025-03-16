import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?

    func login(email: String, password: String) {
        guard let url = URL(string: "https://kolab-center-api.laravel.cloud/api/login") else {
            errorMessage = "URL tidak valid"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "Data tidak ditemukan"
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    if let token = decodedResponse.data?.token {
                        // Simpan token ke UserDefaults
                        UserDefaults.standard.set(token, forKey: "userToken")
                        
                        // Panggil fungsi untuk mengambil data user dengan token
                        self.fetchUserData(token: token)
                    } else {
                        self.errorMessage = "Token tidak ditemukan"
                    }
                } catch {
                    self.errorMessage = "Gagal decode response login"
                }
            }
        }.resume()
    }
    
    func fetchUserData(token: String) {
        guard let url = URL(string: "https://kolab-center-api.laravel.cloud/api/user") else {
            errorMessage = "URL tidak valid"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "Data user tidak ditemukan"
                    return
                }

                // Simpan data user mentah ke UserDefaults tanpa decode
                if let jsonString = String(data: data, encoding: .utf8) {
                    UserDefaults.standard.set(jsonString, forKey: "userData")
                    print("User data berhasil disimpan ke UserDefaults")
                } else {
                    self.errorMessage = "Gagal mengubah data user ke string"
                }
            }
        }.resume()
    }
}

// Model untuk response login
struct LoginResponse: Codable {
    let data: LoginData?
}

struct LoginData: Codable {
    let token: String
}
