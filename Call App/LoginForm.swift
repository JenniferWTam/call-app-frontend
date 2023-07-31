import SwiftUI

struct LoginForm: View {
    @Binding var loginState: LoginState
    @Binding var email: String
    @Binding var name: String
    @State private var phoneNumber: String = ""
    @State private var showError: Bool = false // Move the showError declaration here


    var body: some View {
        VStack(spacing: 20) {
            Text("Sign in to make your reservation")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            TextField("Username or Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)

            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .foregroundColor(.black)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)

            Button(action: {
                // Check if all fields are filled out
                if isFormValid() {
                    // Successful login
                    self.loginState = .loggedIn(.email, name: self.name, phoneNumber: self.phoneNumber)
                    showError = false // Hide error message
                } else {
                    showError = true // Show error message
                }
            }) {
                Text("Log In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Show error message if fields are not filled out
            if showError {
                Text("All fields must be filled out to continue.")
                    .foregroundColor(.red)
            }

            HStack(spacing: 5) {
                Rectangle()
                    .frame(height: 1)

                Text("OR")

                Rectangle()
                    .frame(height: 1)
            }
            .padding(.horizontal)

            Spacer()

            HStack {
                Text("Don't have an account?")
                NavigationLink(destination: SignUpView()) {
                    Text("Sign up.")
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
    }

    private func isFormValid() -> Bool {
        return !email.isEmpty && !phoneNumber.isEmpty && !name.isEmpty
    }
}
