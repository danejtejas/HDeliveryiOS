//
//  TaskHistoryScreen.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//


import SwiftUI

// MARK: - Models




// MARK: - Task History Screen
struct TaskHistoryScreen: View {

    var onSelectTab : () -> Void
    
    @StateObject var viewModel: TaskHistoryViewModel = TaskHistoryViewModel()
    
    var body: some View {
        
        List($viewModel.tripHistory, id: \.id) { trip in
            
            TaskCardView(task: trip)
            
            
        }
        .background(Color(red: 0.25, green: 0.35, blue: 0.65).opacity(0.05))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    onSelectTab()
                    
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Tasks Histories")
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
                await viewModel.showMyTrip()
                await viewModel.showMyRequests()
            }
        }
        
    }
}

// MARK: - Task Card View
struct TaskCardView: View {
    @Binding var task: TripHistory
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with date and amount
            HStack {
                Image(systemName: "car.fill")
                    .foregroundColor(.black)
                
                Text(task.dateCreated ?? "")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(String(format: "%.2f", task.estimateFare ?? "0"))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Int(task.fareInt) < 0 ? Color.red : Color.green)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(Color.white)
            
            // Task details
            VStack(alignment: .leading, spacing: 12) {
                DetailRow(label: "Task Id", value: "\(task.id)")
                DetailRow(label: "Type", value:  "")
                DetailRow(label: "From A", value: task.startLocation ?? "")
                DetailRow(label: "To B:", value: task.endLocation ?? "")
                DetailRow(label: "Trip", value: task.distanceFormat)
                DetailRow(label: "Task", value:  "0")
                DetailRow(label: "Payment", value: task.paymentMode )
            }
            .padding(15)
            .background(Color(red: 0.25, green: 0.35, blue: 0.65))
        }
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

// MARK: - Detail Row
struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.9))
                .frame(width: 80, alignment: .leading)
                .fontWeight(.medium)
            
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview{
    NavigationStack{
        TaskHistoryScreen(onSelectTab:{})
    }
}
