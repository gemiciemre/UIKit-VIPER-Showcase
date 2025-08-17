//
//  Endpoint.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum HTTPTask {
    case request
    case requestParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?
    )
    case requestParametersAndHeaders(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionalHeaders: HTTPHeaders?
    )
}

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var timeoutInterval: TimeInterval { get }
}

extension Endpoint {
    var baseURL: URL {
        guard let url = URL(string: "https://fakestoreapi.com") else {
            fatalError("Base URL could not be configured.")
        }
        return url
    }
    
    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    var timeoutInterval: TimeInterval {
        return 30.0
    }
}

// MARK: - URLRequest Convertible
extension Endpoint {
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval
        
        // Add headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Configure parameters based on task
        switch task {
        case .request:
            break
            
        case .requestParameters(let bodyParameters, let urlParameters):
            try configureParameters(
                bodyParameters: bodyParameters,
                urlParameters: urlParameters,
                request: &request
            )
            
        case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
            additionalHeaders?.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
            
            try configureParameters(
                bodyParameters: bodyParameters,
                urlParameters: urlParameters,
                request: &request
            )
        }
        
        return request
    }
    
    private func configureParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        request: inout URLRequest
    ) throws {
        if let bodyParameters = bodyParameters {
            try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
        }
        
        if let urlParameters = urlParameters {
            try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
        }
    }
}

// MARK: - Parameter Encoders
struct JSONParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}

struct URLParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.invalidURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(
                    name: key,
                    value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                )
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

// MARK: - Network Error Extension
extension NetworkError {
    static let encodingFailed = NetworkError.unknown("Parameter encoding failed.")
}
