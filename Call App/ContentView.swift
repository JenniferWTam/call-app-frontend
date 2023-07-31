import SwiftUI

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
                        .navigationBarItems(trailing: EmptyView()) // Hide the navigation bar items
                case .loggedIn(_, let userName, let userPhoneNumber):
                    ReservationForm(userName: userName, userPhoneNumber: userPhoneNumber, partySize: $partySize, name: $name, restaurantName: $restaurantName, reservationTime: $reservationTime)
                        .navigationBarItems(trailing: logoutButton) // Show the logout button only when logged in
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 204/255, green: 239/255, blue: 252/255), Color(red: 178/255, green: 218/255, blue: 251/255)]), startPoint: .top, endPoint: .bottom))
            .navigationBarTitle("Reservation App")
            .navigationBarTitleDisplayMode(.inline)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
