//
//  OnlineViewModel.swift
//  HDelivery
//
//  Created by Tejas on 04/10/25.
//

import SwiftUI

class OnlineViewModel: ObservableObject {
    
    private let repository:  DriverRepository
    @Published var isOnline: Bool = false
    @Published var error: String?
    @Published var isLoading: Bool = false
    
    init(repository: DriverRepository = AppDependencies.shared.makeDriverRepository()){
        self.repository = repository
         
    }
    
    func setOnlineDrivers() async   {
        isLoading  = true
        error = nil
        let status = isOnline ? "0" : "1"
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let requset = try await repository.setOnlineStatus(token: token, status: status)
            if  requset.isSuccess {
                isOnline.toggle()
            }
            else {
                error = requset.message
            }
            
        }catch {
//            error = error.localizedDescription
        }
        
    }
    
}
