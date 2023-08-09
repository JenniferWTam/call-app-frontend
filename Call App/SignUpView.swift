// SignUpView.swift

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    // Add more fields as needed for the sign-up process

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 204/255, green: 239/255, blue: 252/255), Color(red: 178/255, green: 218/255, blue: 251/255)]), startPoint: .top, endPoint: .bottom))
    }
}
