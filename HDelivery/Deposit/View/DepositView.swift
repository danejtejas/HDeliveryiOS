import SwiftUI
import PaystackUI
import PaystackCore
import ToastSwiftUI

struct DepositView: View {
    @State private var amount: String = ""
    @State private var showBottomSheet = false
    @State private var email: String = ""
    @State private var sheetAmount: String = ""
    
    @State private var depositAmount: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    private let currentBalance: Double = 199.99
    
    @StateObject var viewModel = DepositViewModel()
    @State private var isLoading: Bool = false
    
    @State var message : String = ""

    
    var body: some View {
       
            ZStack {
                Color(red: 12/255, green: 18/255, blue: 35/255)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    // Balance Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "building.columns.fill")
                            Text("Your Balance")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        
                        Text("₦200.0")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    // Amount Input
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "banknote")
                            Text("Amount(₦)")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        
                        TextField("0", text: $viewModel.amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                            .foregroundColor(.white)
                    }
            
                    
                    Button(action: {
                        Task {
                            await viewModel.doPaymentProcess()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                .font(.title3)
                            Text("Pay")
                                .bold()
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(6)
                        .shadow(radius: 2)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
                
            }
            .navigationBarTitle("Deposit", displayMode: .inline)  // Set the title "Deposit"
            .navigationBarBackButtonHidden()
            .toolbar {
                // Back Button (left side of the navigation bar)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()  // Dismiss the view
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)  // White back button color
                            .font(.system(size: 20, weight: .medium))
                    }
                }
                
                // Title Customization
                ToolbarItem(placement: .principal) {
                    Text("Deposit")
                        .foregroundColor(.white)  // Title color set to white
                        .font(.system(size: 22, weight: .medium))
                }
            }
            .navigationBarHidden(false)  // Ensure the navigation bar is visible
            .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .fullScreenCover(isPresented: $viewModel.isDepositSuccess) {
                PaystackPaymentScreen(checkoutURL: viewModel.checkoutURL)
            }
            .onDisappear(
                perform: {
                    viewModel.stopRepeatingTask()
                }
            )
        
        
    }
}


extension DepositView {
    fileprivate func paymentDone(_ result: TransactionResult) {
        switch result {
        case .completed(let details):
            // IMPORTANT: Verify on your server using /transaction/verify before fulfilling value
            message = "✅ Completed. Ref: \(details.reference)"
        case .cancelled:
            message = "⚠️ Cancelled by user"
        case .error(let error, let reference):
            message = "❌ Error: \(error.message) (ref: \(reference ?? "n/a"))"
        }
    }
}

struct BottomSheetView: View {
    @Binding var email: String
    @Binding var sheetAmount: String
    var onAction : (() -> Void)?
    
    var body: some View {
        VStack(spacing: 20) {
            // Email
            HStack {
                Image(systemName: "banknote")
                Text("Enter your Email Id")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter email", text: $email)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black.opacity(0.7))
                )
                .padding(.horizontal)
            
            // Amount
            HStack {
                Image(systemName: "banknote")
                Text("Amount")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("0", text: $sheetAmount)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black.opacity(0.7))
                )
                .padding(.horizontal)
            
            // Submit Button
            Button(action: {
                onAction?()
            }) {
                Text("SUBMIT")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(6)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 40)
        .presentationDetents([.height(400)])
    }
}

#Preview {
    DepositView()
}

