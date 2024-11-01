// swift/main.swift
import Foundation
import GoogleSignIn

func authenticateWithGoogle() {
    let clientID = Config.googleClientID
    guard !clientID.isEmpty else {
        print("Client ID is missing")
        return
    }

    // Initialize Google Sign-In
    let gSignInConfig = GIDConfiguration(clientID: clientID)
    
    // Simulate Google Sign-In (this would typically be handled in a UI context)
    GIDSignIn.sharedInstance.signIn(with: gSignInConfig, presenting: <#UIViewController#>) { user, error in
        if let error = error {
            print("Error signing in: \(error.localizedDescription)")
            return
        }

        guard let idToken = user?.authentication.idToken else {
            print("Failed to retrieve ID token")
            return
        }

        // Send the ID token to the backend for verification
        verifyToken(with: idToken)
    }
}

func verifyToken(with idToken: String) {
    let backendURL = Config.backendURL

    var request = URLRequest(url: URL(string: backendURL)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try? JSONSerialization.data(withJSONObject: ["idToken": idToken])

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error: \(error?.localizedDescription ?? "No data")")
            return
        }

        if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("Response: \(jsonResponse)")
        } else {
            print("Failed to parse response")
        }
    }
    task.resume()
}

// Run authentication
authenticateWithGoogle()
