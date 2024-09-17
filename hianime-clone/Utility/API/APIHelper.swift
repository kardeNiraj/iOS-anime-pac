//
//  APIHelper.swift
//  hianime-clone
//
//  Created by apple on 22/08/24.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    private let baseURL = Endpoints.BASE_URL
    private let xapi_key = "a86ac04b2bmshbbd6b90f46a5a71p116a7djsn155bf08b145c"
    private let xapi_host = "hianime.p.rapidapi.com"
    
    private init() {}
    
    private var queryCache = [String: Any]()
    
    func makeRequest<T: Decodable>(endpoint: String, method: String = "GET", useCache: Bool = true, completion: @escaping (Result<T, Error>) -> Void) {
        let cacheKey = "\(method)_\(endpoint)"
        
        if useCache, let cachedResponse = queryCache[cacheKey] as? T {
            completion(.success(cachedResponse))
            return
        }
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(xapi_host, forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(xapi_key, forHTTPHeaderField: "x-rapidapi-key")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                
                self?.queryCache[cacheKey] = decodedResponse
                
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
    
    func makeCustomRequest<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        let cacheKey = "GET_\(urlString)"
        
        if let cachedResponse = queryCache[cacheKey] as? T {
            completion(.success(cachedResponse))
            return
        }
        
        guard let url = URL(string: "\(Endpoints.BASE_URL)\(urlString)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(xapi_key, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(xapi_host, forHTTPHeaderField: "x-rapidapi-host")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        dataTask.resume()
    }
    
    func clearCache() {
        queryCache.removeAll()
    }
    
    func clearCache(for endpoint: String, method: String = "GET") {
        let cacheKey = "\(method)_\(endpoint)"
        queryCache.removeValue(forKey: cacheKey)
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
    }
}
