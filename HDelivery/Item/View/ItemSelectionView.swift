import SwiftUI

struct ItemSelectionView: View {
    @StateObject private var viewModel = ItemViewModel()
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
        VStack(spacing: 0) {
            // Loading/Error States
            if viewModel.isLoading {
                Spacer()
                ProgressView("Loading items...")
                    .scaleEffect(1.2)
                Spacer()
            } else if let error = viewModel.error {
                VStack(spacing: 16) {
                    Spacer()
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    
                    Text("Error loading items")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(error)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button("Retry") {
                        viewModel.retry()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Spacer()
                }
            } else {
                // Items List
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.items.indices, id: \.self) { index in
                            ItemRowView(
                                item: $viewModel.items[index],
                                onToggle: { 
                                    viewModel.toggleItemSelection(viewModel.items[index])
                                },
                                onDecrement: {
                                    viewModel.decrementQuantity(for: viewModel.items[index])
                                },
                                onIncrement: { 
                                    viewModel.incrementQuantity(for: viewModel.items[index])
                                }
                            )
                        }
                    }
                }
                
                // Total Footer
                Button(action: {
                    print("Selected items: \(viewModel.selectedItems)")
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Total: ₦ \(viewModel.totalPrice) (\(viewModel.selectedItemsCount) items)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(viewModel.selectedItemsCount > 0 ? Color.green : Color.gray)
                }
                .disabled(viewModel.selectedItemsCount == 0)
            }
            
           
        }
        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()

                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Select Item(s)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.fetchAllItems()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            viewModel.fetchAllItems()
        }
        
    }
}
struct ItemRowView: View {
    @Binding var item: Item
    var onToggle: () -> Void
    var onDecrement: () -> Void
    var onIncrement: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                // Checkbox
                Button(action: onToggle) {
                    Image(systemName: item.isSelected ? "checkmark.square.fill" : "square")
                        .font(.title2)
                        .foregroundColor(item.isSelected ? Color(red: 0.25, green: 0.45, blue: 0.75) : .gray)
                }
                
                // Item Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    
                    Text("₦ \(item.price)")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Quantity Controls (only for selected items)
                if item.isSelected {
                    HStack(spacing: 8) {
                        Button(action: onDecrement) {
                            Image(systemName: "minus")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .background(Color.red)
                                .cornerRadius(4)
                        }
                        
                        Text("\(item.quantity)")
                            .font(.system(size: 16))
                            .frame(width: 20)
                        
                        Button(action: onIncrement) {
                            Image(systemName: "plus")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .background(Color.green)
                                .cornerRadius(4)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            // Description TextField (only for selected items)
            if item.isSelected {
                TextField("Short description about your item", text: $item.description)
                    .padding(12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
            }
            
            // Divider
            Divider()
                .padding(.leading, 16)
        }
        .background(Color.white)
    }
}



#Preview {
    ItemSelectionView()
}
