import Foundation

struct Config {
    static let googleClientID: String = ProcessInfo.processInfo.environment["GOOGLE_CLIENT_ID"] ?? ""
}