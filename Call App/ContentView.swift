import SwiftUI
import MapKit

struct ContentView: View {
    @State private var loginState: LoginState = .loggedOut
    @AppStorage("name") private var name: String = ""
    @AppStorage("phoneNumber") private var phoneNumber: String = ""
    @State private var partySize = 1
    @State private var reservationTime = Date()
    @State private var restaurantName = ""
    @State private var email: String = ""
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var search: String = ""
    @State private var tapped: Bool = false
    
    private func getNearByLandmarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = restaurantName
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
                
            }
            
        }
        
    }
    
    func calculateOffset() -> CGFloat {
        
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }
        else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                switch loginState {
                case .loggedOut:
                    LoginForm(loginState: $loginState, email: $email, name: $name)
                        .navigationBarItems(trailing: EmptyView())
                case .loggedIn(_, let userName, let userPhoneNumber):
                    ReservationForm(userName: userName, userPhoneNumber: userPhoneNumber, partySize: $partySize, name: $name, restaurantName: $restaurantName, reservationTime: $reservationTime)
                        .navigationBarItems(trailing: logoutButton)
                        .frame(height: UIScreen.main.bounds.size.height / 2)
                        .offset(y: 20)
                        .padding(.bottom, 0)
                    
                    PlaceListView(landmarks: self.landmarks) {
                        self.tapped.toggle()
                    }
                    .animation(.spring(), value: tapped)
                    .offset(y: calculateOffset())

                    TextField("Restaurant Name", text: $restaurantName, onEditingChanged: { _ in }) {
                        self.getNearByLandmarks()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                    MapView(landmarks: landmarks)
                        .frame(height: UIScreen.main.bounds.size.height / 4)

                }
            }
            .foregroundColor(.black)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.5)]), // Adjust colors here
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarTitle("Reservation App")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.white)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            UINavigationBar.appearance().backgroundColor = UIColor.clear
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
        })
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
