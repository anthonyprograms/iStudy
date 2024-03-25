//
//  NetworkManager.swift
//  iStudy
//
//  Created by Anthony Williams on 3/24/24.
//

import Foundation

final class NetworkManager {
    
    enum NetworkError: Error {
        case fileNotFound
        case invalidUrl
    }
    
    private static let apiUrlString = "non-existent-website-going-to-fail"

    static func fetchData() async throws -> [Category] {
        guard let url = URL(string: apiUrlString) else {
            throw NetworkError.invalidUrl
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let categories = try JSONDecoder().decode([Category].self, from: data)
            return categories
        } catch {
            // Expected path!
            // Fallback to JSON file
            return try stubResponse()
        }
    }

    
    private static func stubResponse() throws -> [Category] {
        guard let fileURL = Bundle.main.url(forResource: "defaults", withExtension: "json") else {
            throw NetworkError.fileNotFound
        }
        
        let jsonData = try Data(contentsOf: fileURL)
        let categories = try JSONDecoder().decode([Category].self, from: jsonData)
        return categories
    }
}
