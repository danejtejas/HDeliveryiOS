//
//   TransactionHistoriesView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI



struct TransactionHistoriesView: View {
   
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = TransactionHistoryViewModel()
      
    
    
    var body: some View {
       
        List($viewModel.transactions , id: \.id) { transaction in
            TransactionRowView(transaction: transaction)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
        }

        .background(Color(red: 0.25, green: 0.35, blue: 0.65).opacity(0.05))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Task Histories")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .overlay{
            if viewModel.isLoading {
                LoadView()
            }
        }
        .onAppear {
            Task {
                await viewModel.loadTransactions()
                
            }
        }
        
    }
}


// MARK: - Task Card View
struct TransactionRowView: View {
    @Binding var transaction: Transaction

    
    var body: some View {
        VStack(spacing: 0) {
            // Header with date and amount
            HStack {
                Image(systemName: "car.fill")
                    .foregroundColor(.black)
                
                Text(transaction.dateCreated)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(String(transaction.amount))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(transaction.isNegative ? Color.red : Color.green)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(Color.white)
            
            // Task details
            VStack(alignment: .leading, spacing: 12) {
                DetailRow(label: "Transaction ID", value: "\(transaction.id)")
                DetailRow(label: "Task Id", value:  transaction.tripId ?? "")
                DetailRow(label: "Note", value:  "")
            }
            .padding(15)
            .background(Color(red: 0.25, green: 0.35, blue: 0.65))
        }
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}



#Preview {
    
    NavigationStack {
        TransactionHistoriesView()
    }
}




