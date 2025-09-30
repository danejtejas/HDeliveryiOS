//
//   TransactionHistoriesView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI



struct TransactionHistoriesView: View {
   
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        ZStack {
            // Background gradient
            
            Color.blue.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                // Transaction List
                List(transactions, id: \.id) { transaction in
                    TransactionRowView(transaction: transaction)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .padding(.top, 20)
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .navigationBarTitle("Task Histories", displayMode: .inline)  // Set the navigation title
        
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
            
            // Set navigation bar title color to white
            ToolbarItem(placement: .principal) {
                Text("Task Histories")
                    .font(.title3)
                    .foregroundColor(.white)  // Title color set to white
            }
        }.accentColor(.white) 
    }
}


struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section with date/time and amount
            HStack {
                // Date and time section
                HStack {
                    Image(systemName: "camera")
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                    
                    Text(transaction.dateTimeText)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(.leading, 15)
                .padding(.vertical, 15)
                .background(Color.white)
                
                // Amount section
                Text(transaction.amountText)
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .frame(width: 120)
                    .padding(.vertical, 15)
                    .background(transaction.isNegative ? Color.red : Color.green)
            }
            
            // Transaction details section
            VStack(alignment: .leading, spacing: 12) {
                // Transaction ID
                HStack {
                    Text("Tran.ID")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        
                    
                    Spacer()
                    
                    Text(transaction.transactionID)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
                
                // Task ID
                HStack {
                    Text("Task Id")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        
                    
                    Spacer()
                    
                    if let taskID = transaction.taskID, !taskID.isEmpty {
                        Text(taskID)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                }
                
                // Note
                HStack {
                    Text("Note")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                       
                    
                    Spacer()
                    
                    Text(transaction.note)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.trailing)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .background(Color.clear)
        .cornerRadius(8)
        .padding(.horizontal, 20)
        .padding(.bottom, 15)
    }
}


#Preview {
    
    NavigationStack {
        TransactionHistoriesView()
    }
}


