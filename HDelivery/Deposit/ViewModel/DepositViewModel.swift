//
//  DepositViewModel.swift
//  HDelivery
//
//  Created by Tejas on 12/10/25.
//

import SwiftUI
import PaystackCore

import PaystackUI

@MainActor
class DepositViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var message: String?
    @Published var newBalance: String?
    @Published var exchangedPoints: String?
    @Published var isSuccess = false
    
    @Published var balance : String = "0"
    
    private let repository: PaymentRepository
    @Published var amount = "100"
    @Published var email = ""
    
    var paystack: Paystack?
    @Published var accessCode: String = ""
    @Published var isDepositSuccess: Bool = false
    @Published var checkoutURL : String = ""
    @Published  var timer: Timer? = nil
    let delay: TimeInterval = 5.0 // repeat interval in seconds
    var transactionReference: String = ""
    
    init(repository: PaymentRepository = AppDependencies.shared.makePaymentRepository()) {
        self.repository = repository
        balance = StorageManager.shared.getUserInfo()?.balance ?? "0"
        
        setupPaymentStack()
    }
    
    
    private func setupPaymentStack()  {
        do {
            paystack = try PaystackBuilder
                .newInstance
                .setKey(AppSetting.PayStack.key)
                .build()
        }
        catch {
            print(error)
        }
    }
    
    
    func doPaymentProcess()   {
    
        do {
            let token = try StorageManager.shared.getAuthToken()!
            let userId = StorageManager.shared.getUserInfo()?.id ?? ""
            let emailId = StorageManager.shared.getUserInfo()?.email ?? ""
            print("Token: \(token)")
            
            let dic : [String : Any] = [
                "token"  : token,
                "email"  : emailId,
                "amount"  : amount,
                "user_id" : userId
            ]
            
            
            let postData =  dic.toFormURLEncodedData()

            var request = URLRequest(url: URL(string: "https://hapihyper.com/admin/api/InitiateTransaction")!,timeoutInterval: Double.infinity)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("PHPSESSID=7987ac5744a165b80dd3ac56778df7a6", forHTTPHeaderField: "Cookie")

            request.httpMethod = "POST"
            request.httpBody = postData

            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              print(String(data: data, encoding: .utf8)!)
                DispatchQueue.main.async {
                    let jsonData : [String: Any] = try!  JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                    self.transactionReference = jsonData["reference"] as? String ?? ""
                    let urlString =   jsonData["data"] as? String ?? ""
                    self.checkoutURL = urlString
                    if let url = URL(string: urlString) {
                        let lastPathComponent = url.lastPathComponent
                        self.accessCode = lastPathComponent
                        self.isDepositSuccess = true
                      
                        self.startRepeatingTask()
                        
                    }
                }
            }

            task.resume()
        }
        catch {
            print(error)
        }
         
    }
    
    func observingPayment()   {
    
        do {
            let token = try StorageManager.shared.getAuthToken()!
            let userId = StorageManager.shared.getUserInfo()?.id ?? ""
            print("Token: \(token)")
            
            let dic : [String : Any] = [
                "reference"  : transactionReference,
                "user_id" : userId
            ]
            
            
            let postData =  dic.toFormURLEncodedData()

            var request = URLRequest(url: URL(string: "https://hapihyper.com/admin/api/CheckPaymentStatus")!,timeoutInterval: Double.infinity)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("PHPSESSID=7987ac5744a165b80dd3ac56778df7a6", forHTTPHeaderField: "Cookie")

            request.httpMethod = "POST"
            request.httpBody = postData

            
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              print(String(data: data, encoding: .utf8)!)
                DispatchQueue.main.async {
                    let jsonData : [String: Any] = try!  JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
//                    self.accessCode = jsonData["reference"] as? String ?? ""
                 
                    let status =   jsonData["status"] as? String ?? ""
                  
                    if  status == "1" {
                        self.stopRepeatingTask()
                    }
                }
            }

            task.resume()
        }
        catch {
            print(error)
        }
         
    }
    
    
    func exchangePoints(token: String, amount: String, exchangeType: String?, transactionId : String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await repository.pointExchange(token:token , amount: amount, transactionId: transactionId, paymentMethod: "3")
            
            message = response.message
            if response.status == "SUCCESS" {
                isSuccess = true
//                newBalance = response.data?.newBalance
//                exchangedPoints = response.data?.exchangedPoints
            }
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
        }
    }
}


extension DepositViewModel {
    func stopRepeatingTask() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Start Repeating Task
    func startRepeatingTask() {
        isLoading = true
        stopRepeatingTask() // stop previous timer if any

        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { _ in
            self.observingPayment()
        }
    }
    
    
}




import SwiftUI

struct PaymentObserverView: View {
    @State private var isLoading = false
    @State private var timer: Timer? = nil
    let delay: TimeInterval = 5.0 // repeat interval in seconds

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Checking payment...")
                    .padding()
            }

            Button(action: startRepeatingTask) {
                Text("Start Observing Payment")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: stopRepeatingTask) {
                Text("Stop Observing")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onDisappear {
            stopRepeatingTask()
        }
    }

    // MARK: - Start Repeating Task
    func startRepeatingTask() {
        isLoading = true
        stopRepeatingTask() // stop previous timer if any

        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { _ in
            observingPayment()
        }
    }

    // MARK: - Stop Repeating Task
    func stopRepeatingTask() {
        timer?.invalidate()
        timer = nil
        isLoading = false
    }

    // MARK: - Your Repeating Function
    func observingPayment() {
        print("🔁 Checking payment status...")
        // your payment observation logic here
    }
}
