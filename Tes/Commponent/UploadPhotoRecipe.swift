import SwiftUI
import PhotosUI

struct ExtractedResponseRecipe: Codable {
    let foodName: String
    let recipe: Array<String>
    let step: Array<String>
}

struct UploadPhotoRecipe: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var response: ExtractedResponseRecipe? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        if(isLoading == true){
            ProgressView("Generate Resep...")
                .padding()
        }
        else if (response == nil) {
            VStack {
                if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                    Button(action : {
                        showActionSheet()
                    }) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                } else {
                    Button(action: {
                        showActionSheet()
                    }) {
                        VStack {
                            Image(systemName: "photo.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray.opacity(0.8))
                            Text("Unggah foto di sini")
                                .foregroundColor(.gray)
                                .font(.body)
                        }
                        
                        
                    }
                }
            }
            .frame(height: 230)
            .frame(maxWidth: .infinity)
            .overlay(
                            RoundedRectangle(cornerRadius: 12) // Border dengan sudut lengkung
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5])) // Garis putus-putus
                                .foregroundColor(.gray) // Warna border
                        )
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            )
            .padding(.horizontal)
            .padding(.vertical, 20)
            .photosPicker(isPresented: Binding(
                get: { sourceType == .photoLibrary && showImagePicker },
                set: { if !$0 { showImagePicker = false } }
            ), selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) { oldItem, newItem in
                Task {
                    if let newItem,
                       let data = try? await newItem.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
            .sheet(isPresented: Binding(
                get: { sourceType == .camera && showImagePicker },
                set: { if !$0 { showImagePicker = false } }
            )) {
                ImagePicker(selectedImageData: $selectedImageData, sourceType: sourceType)
            }
            
            ButtomSubmit_2(selectedImageData: $selectedImageData, response: $response, isLoading: $isLoading)
        } else {
            VStack {
                GenerateSeiri(nameFood: response?.foodName, ingredients: response?.recipe, steps: response?.step)
                Button(action: {
                            resetForm()
                        }) {
                            Text("Capture Foto Lagi")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity) // Tombol full lebar layar
                                .padding(.vertical, 20)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange))
                        }
                        .padding(.horizontal, 16) // Beri padding agar tidak mepet ke tepi layar
                        .padding(.top, 20)
            }
        }
    }
    
    private func resetForm() {
        selectedItem = nil
        selectedImageData = nil
        response = nil
    }
    
    private func showActionSheet() {
        let alert = UIAlertController(title: "Pilih Sumber", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Kamera", style: .default) { _ in
            sourceType = .camera
            showImagePicker = true
        }
        
        let libraryAction = UIAlertAction(title: "Galeri", style: .default) { _ in
            sourceType = .photoLibrary
            showImagePicker = true
        }
        
        let cancelAction = UIAlertAction(title: "Batal", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(alert, animated: true)
        }
    }
}

// MARK: - Tombol Submit
struct ButtomSubmit_2: View {
    @Binding var selectedImageData: Data?
    @Binding var response: ExtractedResponseRecipe?
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                isLoading = true
                uploadImage()
            }) {
                Text("Mulai Generate Resep")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 100)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange))
            }.frame(maxWidth: .infinity)
        }
    }

    // Fungsi untuk mengunggah gambar ke API Gemini
    func uploadImage() {
        guard let imageData = selectedImageData else {
            isLoading = false
            print("No image selected")
            return
        }

        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyA94oP_flPWU2vPABXXheHZBYjwaK76iEM")! // Ganti dengan API Key kamu
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Konversi gambar ke Base64
        let base64Image = imageData.base64EncodedString()

        // Format JSON sesuai dengan API Gemini
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        [
                            "text": """
                                Deteksi dan identifikasi semua bahan makanan yang terdapat dalam gambar ini. klasifikasikan bahan berdasarkan kategori seperti sayuran, buah, daging, rempah, atau lainnya.

                                Berdasarkan bahan-bahan yang terdeteksi, buat satu ide masakan yang menggunakan bahan utama dari gambar, dan tambahkan bahan tambahan jika diperlukan. Sajikan resep dalam format JSON sebagai berikut:
                                langsung json saja, tidak perlu basa basi!
                                
                                {
                                  "foodName": "Nama makanan",
                                  "recipe": ["Daftar bahan"],
                                  "step": ["Langkah-langkah memasak"]
                                }

                                Pastikan bahan dari gambar tetap digunakan dalam resep.
                                
                                """

                        ],
                        [
                            "inline_data": [
                                "mime_type": "image/jpeg",
                                "data": base64Image
                            ]
                        ]
                    ]
                ]
            ]
        ]

        // Konversi dictionary ke JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted) else {
            print("Failed to encode JSON")
            return
        }

        request.httpBody = jsonData

        // Jalankan request ke API Gemini
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Upload failed: \(error.localizedDescription)")
                return
            }

            struct GeminiResponse: Codable {
                struct Candidate: Codable {
                    struct Content: Codable {
                        struct Part: Codable {
                            let text: String
                        }
                        let parts: [Part]
                    }
                    let content: Content
                }
                let candidates: [Candidate]
            }

            // Parsing JSON
            if let jsonData = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(GeminiResponse.self, from: jsonData)
                    print(decodedResponse)
                    
                    if let rawText = decodedResponse.candidates.first?.content.parts.first?.text {
                        isLoading = false
                        selectedImageData = nil
                        // Bersihkan teks JSON dari wrapper ```json ... ```
                        let cleanedText = rawText
                            .replacingOccurrences(of: "```json", with: "")
                            .replacingOccurrences(of: "```", with: "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        // Gantilah bagian decoding ini:
                        if let jsonData = cleanedText.data(using: .utf8) {
                            let extractedResponse = try JSONDecoder().decode(ExtractedResponseRecipe.self, from: jsonData)
                            print(extractedResponse)
                            // Perbarui @State di thread utama
                            DispatchQueue.main.async {
                                self.response = Optional(extractedResponse)
                            }
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

#Preview {
    UploadPhotoRecipe()
}
