//
//  NetworkManager.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.06.2022.
//

import Foundation

// MARK: - TASK 1.1 iosdt
struct NetworkManager {

    static let shared = NetworkManager()

    func fetchData(url: String) {

        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse {
                print("💾data: \(data)\n\(String(decoding: data, as: UTF8.self))")
                print("🖥response: \(response)\n\(response.statusCode)\n \(response.allHeaderFields)")
            }
            if let error = error {
                print("⚠️error: \(error.localizedDescription)")
            }
        }.resume()


    }
}
