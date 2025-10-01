//
//  LoginService.swift
//  HDelivery
//
//  Created by user286520 on 9/30/25.
//

import Foundation
import Combine


//
//struct LoginData : Codable {
//    let emaild : String
//    let password : String
//}
//
//struct LoginRequest : APIRequest {
//    typealias Response = String
//    
//    var path: String = "login"
//    
//    var method: HTTPMethod {.post}
//    
//    let login : LoginData
//    
//    var body: Data? { try? JSONEncoder().encode(login) }
//    
//    
//}
//
//
//protocol LoginRepository {
//    func login(loginData : LoginData)
//}
//
//
//final class APILoginService: LoginRepository {
//    func login(loginData: LoginData) {
//        <#code#>
//    }
//    
//    
//    private let networkClient: NetworkClient
//    
//    init(networkClient: NetworkClient) {
//        self.networkClient = networkClient
//    }
//    
//    func login(loginData : LoginData) async {
//        networkClient.execute(LoginRequest(login: loginData))
//        
//    }
//    
//
//}




class LoginService  {
    static let shared = LoginService()
    
    private init() {}

    
//    func login(username: String, password: String) -> {} {
//        // Simulate network delay
//        let delay = DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            return Bool.random()
//        }
//        
//        return Future<Bool, Error> { promise in
//            delay
//        }
//        .setFailureType(to: Error.self)
//        .eraseToAnyPublisher()
//    }
}
