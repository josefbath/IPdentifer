import SwiftUI

struct ContentView: View {
    @Binding var ipAddress: String

    var body: some View {
        VStack {
            Text("Your Public IPv6 Address:")
                .font(.headline)
            Text(ipAddress)
                .font(.largeTitle)
                .padding()
            Button("Refresh IP Address") {
                fetchPublicIPv6Address { ip in
                    self.ipAddress = ip
                }
            }
            .padding()
        }
        .onAppear {
            fetchPublicIPv6Address { ip in
                self.ipAddress = ip
            }
        }
    }

    func fetchPublicIPv6Address(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "https://api64.ipify.org?format=text") else {
            completion("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion("Error: \(error.localizedDescription)")
                }
                return
            }

            guard let data = data, let ip = String(data: data, encoding: .utf8) else {
                DispatchQueue.main.async {
                    completion("Unable to fetch IP")
                }
                return
            }

            DispatchQueue.main.async {
                completion(ip)
            }
        }

        task.resume()
    }
}
