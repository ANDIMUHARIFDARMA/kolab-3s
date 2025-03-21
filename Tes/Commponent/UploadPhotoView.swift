import SwiftUI
import PhotosUI

// Struktur data untuk decoding JSON
struct ExtractedResponse: Codable {
    let rating: Int
    let reason: String
    let advice: String
    let hairPoint: Float
    let clothingPoint: Float
    let facePoint: Float
}

struct UploadPhotoView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var response: ExtractedResponse? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        if(isLoading == true){
            ProgressView("Memeriksa...")
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
            
            ButtomSubmit_1(selectedImageData: $selectedImageData, response: $response, isLoading: $isLoading)
        } else {
            VStack {
                GenerateSeiso(suggestion: response?.advice, rating: response?.rating, reason: response?.reason, hairPoint: response?.hairPoint, clothingPoint: response?.clothingPoint, facePoint: response?.facePoint)
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
struct ButtomSubmit_1: View {
    @Binding var selectedImageData: Data?
    @Binding var response: ExtractedResponse?
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                isLoading = true
                uploadImage()
            }) {
                Text("Mulai Cek Kerapian")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 110)
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
                                    Bisakah kamu menilai dari rentang 1 sampai 100 seberapa rapi penampilan orang ini dalam konteks pergi ke kantor yang menerapkan budaya semi formal?

                                    Penilaian ini didasarkan pada tiga aspek:
                                    1. Rambut (hairPoint) → Apakah sudah disisir atau terlihat rapi serta sopan? rambut yang dinilai tidak sopan atau tidak rapi adalah model rambut yang terlalu panjang namun tidak diatur atau seperti gaya rambut preman (mohawk, mulet, dan lain lain)
                                    2. Pakaian (clothingPoint) → Apakah sesuai dengan budaya semi formal, tidak terlalu santai atau terlalu formal?
                                    3. Wajah (facePoint) → Apakah terlihat sudah mandi dan bersih?
                            
                                    Peraturan dan batasan di kantor saya:
                                    1. Pakaian yang digunakan adalah semi formal, artinya boleh kasual asalkan sopan, namun lebih dianjurkan untuk menggunakan kemeja.
                                    2. Pakaian yang terlalu formal seperti jas, gaun, dan lain lain dianggap terlalu berlebihan

                                    ### Kriteria Penilaian:
                                    - 1-30 → Sangat tidak rapi, tidak pantas untuk bekerja.
                                    - 31-69 → Kurang rapi, masih bisa diterima tetapi perlu perbaikan.
                                    - 70-94 → Rapi dan sesuai dengan standar semi formal.
                                    - 95-100 → Sangat rapi dan profesional tanpa berlebihan.

                                    Jika orang tersebut berpakaian terlalu berlebihan (misalnya memakai gaun atau jas resmi ke kantor semi formal), maka tetap berikan penilaian tinggi untuk kebersihan dan kerapian, tetapi tambahkan catatan pada "reason" tentang ketidaksesuaian dengan lingkungan kerja.

                                    Jika kamu tidak dapat mendeteksi orang ataupun salah satu kriteria seperti rambut, pakaian, dan wajah dalam gambar, maka gunakan nilai default **0 untuk semua aspek** dan sebutkan dalam "reason".

                                    Berikan hasil dalam format JSON seperti berikut:

                                    {
                                      "rating": nilaiTotalDariRataRataTigaAspek,
                                      "reason": "Alasan mengapa orang ini mendapatkan rating tersebut.",
                                      "advice": "Nasihat agar orang ini bisa tampil lebih rapi sesuai dengan lingkungan kerja. serta sarankan gaya rambut sesuai dengan bentuk wajah orang tersebut jika hair point nya masih dinilai rendah (1-60)",
                                      "hairPoint": nilaiUntukRambut,
                                      "clothingPoint": nilaiUntukPakaian,
                                      "facePoint": nilaiUntukWajah
                                    }
                            
                                    rating adalah rata rata dari hairPoint, clothingPoint, dan facePoint sehingga rentang point 3 hal ini adalah 1-100
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
                            let extractedResponse = try JSONDecoder().decode(ExtractedResponse.self, from: jsonData)
                            print(extractedResponse)
                            // Perbarui @State di thread utama
                            DispatchQueue.main.async {
                                self.response = Optional(extractedResponse)
                                sendToSeiton(score: extractedResponse.rating)
                            }
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func sendToSeiton(score: Int) {
        let seitonURL = URL(string: "https://kolab-center-api.laravel.cloud/api/seiton")!
        
        // Ambil token dari UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            print("Error: No token found.")
            return
        }
        
        var request = URLRequest(url: seitonURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Bearer Token
        
        let seitonRequestBody: [String: Any] = [
            "score": score
        ]
        
        // Encode JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: seitonRequestBody, options: .prettyPrinted) else {
            print("Failed to encode JSON for Seiton API")
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to send to Seiton: \(error.localizedDescription)")
                return
            }
            
            // Cek status code response
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    print("Successfully sent to Seiton API")
                    
                    // Simpan user data ke UserDefaults (contoh penyimpanan hasil dari API)
                    if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                        UserDefaults.standard.set(jsonString, forKey: "userData")
                        print("User data berhasil disimpan ke UserDefaults")
                    }
                } else {
                    print("Failed with status code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
}

// MARK: - ImagePicker untuk Kamera
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImageData: Data?
    var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage,
               let imageData = image.jpegData(compressionQuality: 0.8) {
                parent.selectedImageData = imageData
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    UploadPhotoView()
}
