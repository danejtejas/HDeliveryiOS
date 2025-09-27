//
//   TransactionHistoriesView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI



struct TransactionHistoriesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let transactions: [Transaction] = [
           Transaction(
               id: "1",
               date: Date(),
               amount: -0.01,
               transactionID: "39176AArC188F6201",
               taskID: nil,
               note: "CANCELLATION_ORDER_FEE",
               type: .fee
           ),
           Transaction(
               id: "2",
               date: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(),
               amount: 150.00,
               transactionID: "39176AArC188F6202",
               taskID: "TSK001",
               note: "DEPOSIT",
               type: .credit
           ),
           Transaction(
               id: "3",
               date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
               amount: -25.50,
               transactionID: "39176AArC188F6203",
               taskID: "TSK002",
               note: "WITHDRAWAL_FEE",
               type: .debit
           ),
           Transaction(
                      id: "4",
                      date: Calendar.current.date(byAdding: .hour, value: -5, to: Date()) ?? Date(),
                      amount: -2.50,
                      transactionID: "39176AArC188F6204",
                      taskID: "TSK003",
                      note: "SMS_ALERT_FEE",
                      type: .fee
                  ),
                  Transaction(
                      id: "5",
                      date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
                      amount: 1000.00,
                      transactionID: "39176AArC188F6205",
                      taskID: "TSK004",
                      note: "MOBILE_DEPOSIT",
                      type: .credit
                  ),
                  Transaction(
                      id: "6",
                      date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
                      amount: -45.20,
                      transactionID: "39176AArC188F6206",
                      taskID: "TSK005",
                      note: "FUEL_STATION_PAYMENT",
                      type: .debit
                  ),
                  Transaction(
                      id: "7",
                      date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
                      amount: -5.00,
                      transactionID: "39176AArC188F6207",
                      taskID: nil,
                      note: "MAINTENANCE_FEE",
                      type: .fee
                  ),
                  Transaction(
                      id: "8",
                      date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
                      amount: 750.00,
                      transactionID: "39176AArC188F6208",
                      taskID: "TSK006",
                      note: "FREELANCE_PAYMENT",
                      type: .credit
                  ),
                  Transaction(
                      id: "9",
                      date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
                      amount: -89.99,
                      transactionID: "39176AArC188F6209",
                      taskID: "TSK007",
                      note: "SUBSCRIPTION_PAYMENT",
                      type: .debit
                  ),
                  Transaction(
                      id: "10",
                      date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
                      amount: -320.50,
                      transactionID: "39176AArC188F6210",
                      taskID: "TSK008",
                      note: "UTILITY_BILL_PAYMENT",
                      type: .debit
                  ),
                  Transaction(
                      id: "11",
                      date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
                      amount: 200.00,
                      transactionID: "39176AArC188F6211",
                      taskID: "TSK009",
                      note: "REFUND_PROCESSED",
                      type: .credit
                  ),
                  Transaction(
                      id: "12",
                      date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
                      amount: -12.50,
                      transactionID: "39176AArC188F6212",
                      taskID: "TSK010",
                      note: "ATM_WITHDRAWAL_FEE",
                      type: .fee
                  ),
                  Transaction(
                      id: "13",
                      date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
                      amount: -500.00,
                      transactionID: "39176AArC188F6213",
                      taskID: "TSK011",
                      note: "ATM_CASH_WITHDRAWAL",
                      type: .debit
                  ),
                  Transaction(
                      id: "14",
                      date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(),
                      amount: 1500.00,
                      transactionID: "39176AArC188F6214",
                      taskID: "TSK012",
                      note: "TRANSFER_FROM_SAVINGS",
                      type: .credit
                  ),
                  Transaction(
                      id: "15",
                      date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(),
                      amount: -75.30,
                      transactionID: "39176AArC188F6215",
                      taskID: "TSK013",
                      note: "RESTAURANT_PAYMENT",
                      type: .debit
                  ),
                  Transaction(
                      id: "16",
                      date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                      amount: -1.00,
                      transactionID: "39176AArC188F6216",
                      taskID: nil,
                      note: "INTERNATIONAL_TRANSACTION_FEE",
                      type: .fee
                  ),
                  Transaction(
                      id: "17",
                      date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                      amount: -250.00,
                      transactionID: "39176AArC188F6217",
                      taskID: "TSK014",
                      note: "ONLINE_SHOPPING",
                      type: .debit
                  ),
                  Transaction(
                      id: "18",
                      date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(),
                      amount: 300.00,
                      transactionID: "39176AArC188F6218",
                      taskID: "TSK015",
                      note: "CASH_BACK_REWARD",
                      type: .credit
                  ),
                  Transaction(
                      id: "19",
                      date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(),
                      amount: -680.75,
                      transactionID: "39176AArC188F6219",
                      taskID: "TSK016",
                      note: "RENT_PAYMENT",
                      type: .debit
                  ),
                  Transaction(
                      id: "20",
                      date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
                      amount: -15.00,
                      transactionID: "39176AArC188F6220",
                      taskID: nil,
                      note: "OVERDRAFT_FEE",
                      type: .fee
                  ),
                  Transaction(
                      id: "21",
                      date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
                      amount: 3200.00,
                      transactionID: "39176AArC188F6221",
                      taskID: "TSK017",
                      note: "BONUS_PAYMENT",
                      type: .credit
                  ),
                  Transaction(
                      id: "22",
                      date: Calendar.current.date(byAdding: .day, value: -8, to: Date()) ?? Date(),
                      amount: -125.40,
                      transactionID: "39176AArC188F6222",
                      taskID: "TSK018",
                      note: "PHARMACY_PAYMENT",
                      type: .debit
                  ),
                  Transaction(
                      id: "23",
                      date: Calendar.current.date(byAdding: .day, value: -8, to: Date()) ?? Date(),
                      amount: -3.75,
                      transactionID: "39176AArC188F6223",
                      taskID: "TSK019",
                      note: "FOREIGN_EXCHANGE_FEE",
                      type: .fee
                  ),
                  Transaction(
                      id: "24",
                      date: Calendar.current.date(byAdding: .day, value: -9, to: Date()) ?? Date(),
                      amount: 850.00,
                      transactionID: "39176AArC188F6224",
                      taskID: "TSK020",
                      note: "INVESTMENT_DIVIDEND",
                      type: .credit
                  ),
                  Transaction(
                      id: "25",
                      date: Calendar.current.date(byAdding: .day, value: -10, to: Date()) ?? Date(),
                      amount: -199.99,
                      transactionID: "39176AArC188F6225",
                      taskID: "TSK021",
                      note: "INSURANCE_PREMIUM",
                      type: .debit
                  )
       ]
    
    var body: some View {
        ZStack {
            // Background gradient
          
            Color.blue.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Status Bar
            
                // Custom Navigation Bar
                HStack {
                                   Button(action: {
                                       presentationMode.wrappedValue.dismiss()
                                   }) {
                                       Image(systemName: "arrow.left")
                                           .foregroundColor(.white)
                                           .font(.system(size: 20, weight: .medium))
                                   }
                                   
                                   Spacer()
                                   
                                   Text("Transaction Histories")
                                       .foregroundColor(.white)
                                       .font(.system(size: 22, weight: .medium))
                                   
                                   Spacer()
                               }
                               .padding(.horizontal, 20)
                               .padding(.top, 20)
                               
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
        .navigationBarHidden(true)
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
    TransactionHistoriesView()
}


struct Transaction {
    let id: String
    let date: Date
    let amount: Double
    let transactionID: String
    let taskID: String?
    let note: String
    let type: TransactionType
    
    enum TransactionType {
        case debit
        case credit
        case fee
    }
    
    var isNegative: Bool {
        return amount < 0
    }
    
    var amountText: String {
        return String(format: "%.2f", amount)
    }
    
    var dateTimeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}
