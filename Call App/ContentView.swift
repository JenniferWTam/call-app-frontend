//
//  ContentView.swift
//  Call App
//
//  Created by Jennifer Tam on 7/24/23.
//

import SwiftUI

enum AuthenticationMethod {
    case email
    case phone
    case gmail
}

enum LoginState: Hashable {
    case loggedOut
    case loggedIn(AuthenticationMethod, name: String, phoneNumber: String)
}

struct ContentView: View {
    @State private var loginState: LoginState = .loggedOut
    @AppStorage("name") private var name: String = ""
    @AppStorage("phoneNumber") private var phoneNumber: String = ""
    @State private var partySize = 1
    @State private var reservationTime = Date()
    @State private var restaurantName = ""
    @State private var email: String = ""

    var body: some View {
        NavigationView {
            VStack {
                switch loginState {
                case .loggedOut:
                    LoginForm(loginState: $loginState, email: $email, name: $name)
                case .loggedIn(_, let userName, let userPhoneNumber):
                    ReservationForm(userName: userName, userPhoneNumber: userPhoneNumber, partySize: $partySize, name: $name, restaurantName: $restaurantName, reservationTime: $reservationTime)
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 204/255, green: 239/255, blue: 252/255), Color(red: 178/255, green: 218/255, blue: 251/255)]), startPoint: .top, endPoint: .bottom))
            .navigationBarTitle("Reservation App")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: logoutButton)
            .foregroundColor(.white)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // (Optional) Use this line to apply the style for iOS 14 and below
    }

    private func logout() {
        loginState = .loggedOut
        name = ""
        phoneNumber = ""
        partySize = 1
        reservationTime = Date()
    }

    private var logoutButton: some View {
        Button(action: {
            logout()
        }) {
            Text("Logout")
        }
    }
}

struct LoginForm: View {
    @Binding var loginState: LoginState
    @Binding var email: String
    @Binding var name: String
    @State private var phoneNumber: String = ""

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
                // Successful login
                self.loginState = .loggedIn(.email, name: self.name, phoneNumber: self.phoneNumber)
            }) {
                Text("Log In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            HStack(spacing: 5) {
                Rectangle()
//                    .fill(Color.gray)
                    .frame(height: 1)

                Text("OR")

                Rectangle()
//                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal)

            Spacer()

            HStack {
                Text("Don't have an account?")
                Button(action: {
                    // Perform signup action here
                }) {
                    Text("Sign up.")
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
    }
}

struct ReservationForm: View {
    var userName: String
    var userPhoneNumber: String
    @Binding var partySize: Int
    @Binding var name: String
    @Binding var restaurantName: String
    @Binding var reservationTime: Date

    var body: some View {
        Form {
            Section(header: Text("Reservation Details")) {
                Text("Name: \(userName)")
                    .foregroundColor(.black) // Set font color to black
                Text("Phone Number: \(userPhoneNumber)")
                    .foregroundColor(.black) // Set font color to black
                TextField("Restaurant", text: $restaurantName)
                    .foregroundColor(.black)
                Stepper("Party Size: \(partySize)", value: $partySize, in: 1...10)
                    .foregroundColor(.black)
                DatePicker("Date and Time", selection: $reservationTime, displayedComponents: [.date, .hourAndMinute])
                    .foregroundColor(.black)
            }
        }
        .accentColor(.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
    }
}

extension LoginState {
    func getAuthenticationMethod() -> AuthenticationMethod? {
        switch self {
        case .loggedIn(let authMethod, _, _):
            return authMethod
        default:
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

