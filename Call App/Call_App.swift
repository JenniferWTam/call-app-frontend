import SwiftUI
import Firebase
import GoogleSignIn

@main
struct Call_AppApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }}
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey :
                                                                    Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    @available(iOS 16.0, *)
    func application(_ application: UIApplication, open url: URL, options:
                     [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
