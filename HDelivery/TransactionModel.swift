//
//  TransactionModel.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//


import SwiftUI


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


let transactions: [Transaction] = 
[
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
