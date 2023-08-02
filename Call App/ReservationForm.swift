import SwiftUI

struct ReservationForm: View {
    var userName: String
    var userPhoneNumber: String
    @Binding var partySize: Int
    @Binding var name: String
    @Binding var restaurantName: String
    @Binding var reservationTime: Date

    var body: some View {
        Form {
            Section(header: Text("Reservation Details")
            ) {
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
                Button(action: {
                    // Call the function to make the reservation
                    makeReservation()
                }) {
                    Text("Make Reservation")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }.scrollContentBackground(.hidden)
    }


    private func makeReservation() {
        // Extract the necessary details
        let reservationDetails = [
            "name": userName,
            "phoneNumber": userPhoneNumber,
            "partySize": partySize,
            "restaurantName": restaurantName,
            "reservationTime": reservationTime
        ] as [String : Any]

        // Convert the details to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: reservationDetails) else {
            return
        }

        // Prepare the URL for the backend API
        let url = URL(string: "http://127.0.0.1:5000/make_reservation")!

        // Create the URL request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Perform the API call
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response from the server (e.g., show an alert to the user)
            if let error = error {
                print("Error: \(error)")
                // Show an error alert to the user
            } else if let data = data {
                // Handle the response data from the server (if needed)
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                // Show a success message to the user (optional)
            }
        }.resume()
    }
}
