import Foundation

enum AuthenticationMethod {
    case email
    case phone
    case gmail
}

enum LoginState: Hashable {
    case loggedOut
    case loggedIn(AuthenticationMethod, name: String, phoneNumber: String)
}
