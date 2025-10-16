//
//  APIService.swift
//  HDelivery
//
//  Created by user286520 on 9/30/25.
//


import Foundation
import Combine

// MARK: - Single Responsibility Principle: Each protocol has one clear purpose

/// Defines HTTP methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

/// Base protocol for all API requests
protocol APIRequest {
    associatedtype Response: Decodable
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }

}

// Default implementations
extension APIRequest {
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
}


// Standard API Response Wrapper
struct APIResponse<T: Decodable>: Decodable {
    let status: String
    let data: T?
    let message: String?
    let count: Int?
    var isSuccess: Bool {
        status == "success".uppercased()
    }
    
}







// MARK: - Network Client Protocol (Dependency Inversion)

/// Abstract protocol for network operations
protocol NetworkClient {
    func execute<T: APIRequest>(_ request: T) async throws -> T.Response
    func executePublisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error>
}

// MARK: - URL Builder (Single Responsibility)

protocol URLBuilding {
    func buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]?) throws -> URL
}

struct URLBuilder: URLBuilding {
    enum URLBuilderError: LocalizedError {
        case invalidBaseURL
        case invalidComponents
        
        var errorDescription: String? {
            switch self {
            case .invalidBaseURL: return "Invalid base URL"
            case .invalidComponents: return "Failed to create URL components"
            }
        }
    }
    
    func buildURL(baseURL: String, path: String, queryItems: [URLQueryItem]?) throws -> URL {
        guard var components = URLComponents(string: baseURL) else {
            throw URLBuilderError.invalidBaseURL
        }
        
        // Properly append the path to existing base URL path
        let existingPath = components.path
        let separator = existingPath.hasSuffix("/") ? "" : "/"
        let newPath = path.hasPrefix("/") ? String(path.dropFirst()) : path
        components.path = existingPath + separator + newPath
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            print("Failed to create URL with baseURL: \(baseURL), path: \(path)")
            print("Final components path: \(components.path)")
            throw URLBuilderError.invalidComponents
        }
        
        print("Successfully created URL: \(url)")
        return url
    }
}

// MARK: - Request Builder (Single Responsibility)

protocol RequestBuilding {
    func buildRequest<T: APIRequest>(from apiRequest: T, url: URL) throws -> URLRequest
}

struct RequestBuilder: RequestBuilding {
    func buildRequest<T: APIRequest>(from apiRequest: T, url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue
        request.httpBody = apiRequest.body
        
        // Set default headers
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Add custom header
        if let headers = apiRequest.headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        
        return request
    }
}

// MARK: - Response Handler (Single Responsibility)

protocol ResponseHandling {
    func handle<T: Decodable>(data: Data, response: URLResponse) throws -> T
}

struct ResponseHandler: ResponseHandling {
    enum NetworkError: LocalizedError {
        case invalidResponse
        case httpError(statusCode: Int, data: Data?)
        case decodingError(Error)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "Invalid response from server"
            case .httpError(let statusCode, _):
                return "HTTP Error: \(statusCode)"
            case .decodingError(let error):
                return "Decoding failed: \(error.localizedDescription)"
            case .unknown:
                return "Unknown error occurred"
            }
        }
    }
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func handle<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
        }
        
        do {
            let string = String(data: data, encoding: .utf8)
            print("API URL: \(String(describing: httpResponse.url))")
            print("API RESPONSE:")
            print(string ?? "")
            let responseObject = try decoder.decode(T.self, from: data)
            
            return responseObject
        } catch {
            print("JSON Decoding Error:  \(error.localizedDescription) ")
            throw NetworkError.decodingError(error)
        }
    }
}

// MARK: - API Service (Open/Closed Principle - open for extension via protocols)

final class APIService: NetworkClient {
    private let baseURL: String
    private let session: URLSession
    private let urlBuilder: URLBuilding
    private let requestBuilder: RequestBuilding
    private let responseHandler: ResponseHandling
    
    init(
        baseURL: String,
        session: URLSession = .shared,
        urlBuilder: URLBuilding = URLBuilder(),
        requestBuilder: RequestBuilding = RequestBuilder(),
        responseHandler: ResponseHandling = ResponseHandler()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
        self.responseHandler = responseHandler
    }
    
    // Async/Await implementation
    func execute<T: APIRequest>(_ request: T) async throws -> T.Response {
        let url = try urlBuilder.buildURL(
            baseURL: baseURL,
            path: request.path,
            queryItems: request.queryItems
        )
        
        let urlRequest = try requestBuilder.buildRequest(from: request, url: url)
        
        let (data, response) = try await session.data(for: urlRequest)
        
        return try responseHandler.handle(data: data, response: response)
    }
    
    // Combine implementation
    func executePublisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        do {
            let url = try urlBuilder.buildURL(
                baseURL: baseURL,
                path: request.path,
                queryItems: request.queryItems
            )
            
            let urlRequest = try requestBuilder.buildRequest(from: request, url: url)
            
            return session.dataTaskPublisher(for: urlRequest)
                .tryMap { [responseHandler] data, response in
                    try responseHandler.handle(data: data, response: response)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - Example Usage



struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

// API Requests (Interface Segregation - specific requests for specific needs)
struct GetUsersRequest: APIRequest {
    typealias Response = [User]
    var path: String { "/users" }
    var method: HTTPMethod { .get }
}

struct GetUserRequest: APIRequest {
    typealias Response = User
    let userId: Int
    var path: String { "/users/\(userId)" }
    var method: HTTPMethod { .get }
}

struct CreateUserRequest: APIRequest {
    typealias Response = User
    var path: String { "/users" }
    var method: HTTPMethod { .post }
    let user: User
    
    var body: Data? {
        try? JSONEncoder().encode(user)
    }
}

struct GetPostsRequest: APIRequest {
    typealias Response = [Post]
    let userId: Int?
    
    var path: String { "/posts" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? {
        guard let userId = userId else { return nil }
        return [URLQueryItem(name: "userId", value: "\(userId)")]
    }
}

// MARK: - Repository Pattern (Liskov Substitution Principle)

protocol UserRepository {
    // other user methods ...
    func showUserInfo(token: String) async throws -> APIResponse<UserInfo>
    
    func changePassword(token: String, oldPassword: String, newPassword: String) async throws -> APIResponse<String>
    
    
    func updateProfile(request: UpdateProfileRequest) async throws -> APIResponse<UserInfo>
    
    

    
}



final class APIUserRepository: UserRepository {
    private let network: NetworkClient
    
    init(network: NetworkClient) {
        self.network = network
    }
    
    func showUserInfo(token: String) async throws -> APIResponse<UserInfo> {
        try await network.execute(ShowUserInfoRequest(token: token))
    }
    

    func changePassword(token: String, oldPassword: String, newPassword: String) async throws -> APIResponse<String> {
           try await network.execute(ChangePasswordRequest(token: token, oldPassword: oldPassword, newPassword: newPassword))
       }
    
    func updateProfile(request: UpdateProfileRequest) async throws -> APIResponse<UserInfo> {
        try await network.execute(request)
    }
    
    
}


// MARK: - Mock for Testing (Dependency Inversion)

final class MockNetworkClient: NetworkClient {
    var mockResponse: Any?
    var shouldFail = false
    
    func execute<T: APIRequest>(_ request: T) async throws -> T.Response {
        if shouldFail {
            throw ResponseHandler.NetworkError.unknown
        }
        
        guard let response = mockResponse as? T.Response else {
            throw ResponseHandler.NetworkError.invalidResponse
        }
        
        return response
    }
    
    func executePublisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        if shouldFail {
            return Fail(error: ResponseHandler.NetworkError.unknown)
                .eraseToAnyPublisher()
        }
        
        guard let response = mockResponse as? T.Response else {
            return Fail(error: ResponseHandler.NetworkError.invalidResponse)
                .eraseToAnyPublisher()
        }
        
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}


