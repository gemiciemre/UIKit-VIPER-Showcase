//
//  NetworkManager.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
    
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        request(endpoint, responseType: T.self, completion: completion)
    }
    
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let request: URLRequest
        
        do {
            request = try endpoint.asURLRequest()
        } catch let error as NetworkError {
            completion(.failure(error))
            return
        } catch {
            completion(.failure(.unknown(error.localizedDescription)))
            return
        }
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            // Check for network errors
            if let error = error {
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noInternetConnection))
                } else {
                    completion(.failure(.unknown(error.localizedDescription)))
                }
                return
            }
            
            // Check for valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Check status code
            guard (200...299).contains(httpResponse.statusCode) else {
                let statusCode = httpResponse.statusCode
                let statusMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                completion(.failure(.serverError("Status: \(statusCode) - \(statusMessage)")))
                return
            }
            
            // Check if data exists
            guard let data = data, !data.isEmpty else {
                completion(.failure(.noData))
                return
            }
            
            // Decode the response
            do {
                let decodedResponse = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                print("Decoding error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: - Convenience Methods
    
    func request<T: Decodable>(
        path: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let endpoint = BasicEndpoint(
            path: path,
            method: method,
            task: parameters != nil ? .requestParameters(bodyParameters: parameters, urlParameters: nil) : .request,
            headers: headers
        )
        
        request(endpoint, completion: completion)
    }
}

// MARK: - Basic Endpoint

private struct BasicEndpoint: Endpoint {
    var path: String
    var method: HTTPMethod
    var task: HTTPTask
    var headers: HTTPHeaders?
}
