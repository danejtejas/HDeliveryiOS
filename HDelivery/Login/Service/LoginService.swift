//
//  LoginService.swift
//  HDelivery
//
//  Created by user286520 on 9/30/25.
//

import Foundation
import Combine

/// Service class that uses LoginRepository for authentication operations
class LoginService {
    static let shared = LoginService()
    
    private let repository: LoginRepository
    
    // Default initializer uses production repository
    private init() {
        self.repository = LoginRepositoryAPI(networkClient: APIService(baseURL: AppSetting.URLS.baseURL))
    }
    
    // Initializer for dependency injection (useful for testing)
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    /// Login with email and password
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        return repository.login(email: email, password: password)
    }
    
    /// Login with LoginModel (for backward compatibility)
    func login(loginModel: LoginModel) -> AnyPublisher<LoginResponse, Error> {
        return repository.login(email: loginModel.email, password: loginModel.password)
    }
    
    
   
    func login(loginRequest : LoginRequest)  -> AnyPublisher<LoginResponse, Error>  {
        return repository.login(request: loginRequest)
    }
    // Logout current user
    func logout() -> AnyPublisher<Bool, Error> {
        return repository.logout()
    }
//    
   
    
    // Check if user is logged in
    func isLoggedIn() -> Bool {
        return repository.isLoggedIn()
    }
    
    /// Get current user
    func getCurrentUser() -> AnyPublisher<User?, Error> {
        return repository.getCurrentUser()
    }
    
    /// Get auth token
    func getAuthToken() -> String? {
        return repository.getAuthToken()
    }
    
    /// Clear all authentication data
    func clearAuthData() {
        repository.clearAuthData()
    }
}

// MARK: - Login Errors

enum LoginError: Error, LocalizedError {
    case invalidCredentials
    case noRefreshToken
    case networkError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password"
        case .noRefreshToken:
            return "No refresh token available"
        case .networkError:
            return "Network connection error"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
