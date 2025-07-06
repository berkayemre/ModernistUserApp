//
//  APIService.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import Foundation
import Combine

class APIService: ObservableObject {
    static let shared = APIService()
    private let session = URLSession.shared
    
    private init() {}
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
