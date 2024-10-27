@main
public struct swift {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(swift().text)
    }
}
import SwiftUI

struct ContentView: View {
    @State private var message = "Fetching..."

    var body: some View {
        VStack {
            Text(message)
                .padding()
                .onAppear {
                    fetchData()
                }
        }
    }

    func fetchData() {
        guard let url = URL(string: "http://localhost:8080/data") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let messageData = try? JSONDecoder().decode([String: String].self, from: data)
                DispatchQueue.main.async {
                    message = messageData?["message"] ?? "No data received"
                }
            } else {
                DispatchQueue.main.async {
                    message = "Error: \(error?.localizedDescription ?? "Unknown error")"
                }
            }
        }.resume()
    }
}
