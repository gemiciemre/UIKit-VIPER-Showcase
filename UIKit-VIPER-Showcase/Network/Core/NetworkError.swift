//
//  NetworkError.swift
//  UIKit-VIPER-Showcase
//
//  Created by Emre GEMİCİ on 17.08.2025.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case serverError(String)
    case unknown(String)
    case noInternetConnection
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .noData:
            return "No data received from server"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let message):
            return "Server error: \(message)"
        case .unknown(let message):
            return "An unknown error occurred: \(message)"
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        case .invalidResponse:
            return "Received an invalid response from the server"
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData),
             (.decodingError, .decodingError),
             (.noInternetConnection, .noInternetConnection):
            return true
        case (.serverError(let lhsMessage), .serverError(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.unknown(let lhsMessage), .unknown(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
