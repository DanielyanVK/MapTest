//
//  NetowrkRequest.swift
//  WaadsuTask
//
//  Created by Danil Kovalev on 11.07.2022.
//

import Foundation

struct NetowrkRequest {
    private let baseUrl = "https://waadsu.com/api/"
    
    private let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    enum Endpoint: String {
        case russiaGeoJson = "russia.geo.json"
    }
    
    func execute<T: Codable>(closure: ItemClosure<T?>?) {
        let stringUrl = baseUrl + endpoint.rawValue
        guard let url = URL(string: stringUrl) else { return }
        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    closure?(result)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    
    }
}
