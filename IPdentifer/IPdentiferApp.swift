//
//  IPdentiferApp.swift
//  IPdentifer
//
//  Created by JBATH on 7/16/24.
//

import SwiftUI

@main
struct swiftui_menu_barApp: App {
    @State var currentNumber: String = "1"
    @State var ipAddress: String = "Fetching IP..."

    var body: some Scene {
        WindowGroup {
            ContentView(ipAddress: $ipAddress)
                .onAppear {
                    fetchPublicIPv6Address { ip in
                        self.ipAddress = ip
                    }
        
                }
        }
        MenuBarExtra {
            VStack {
                
                Text("Your IP: \(ipAddress)")
                              .padding()
                Button("Refresh IP") {
                    fetchPublicIPv6Address { ip in
                        self.ipAddress = ip
                    }
                }
            }
        } label: {
            Label(ipAddress, systemImage: "network")
        }
        Settings {
                    PreferencesView()
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
