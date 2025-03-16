import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            HeaderLogin()
                .padding()
            
            VStack {
                Text("Email")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                
                CustomTextField(placeholder: "Masukkan email Anda", text: $email, isSecure: false)
            }
            
            VStack {
                Text("Password")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                
                CustomTextField(placeholder: "Masukkan kata sandi", text: $password, isSecure: true)
            }
            
            PrimaryButton(title: viewModel.isLoading ? "Loading..." : "Masuk") {
                viewModel.login(email: email, password: password)
            }
            .disabled(viewModel.isLoading) // Mencegah klik ganda saat loading
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            HStack {
                Text("Belum punya akun?")
                Text("Daftar")
                    .foregroundColor(.cyan)
                    .bold()
            }
            .font(.footnote)
            
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
