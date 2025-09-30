import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    var name: String
    var price: Int
    var isSelected: Bool
    var quantity: Int
    var description: String
}

struct ItemSelectionView: View {
    @State private var items = [
        Item(name: "Clothes", price: 120, isSelected: true, quantity: 1, description: ""),
        Item(name: "Pair of Shoes", price: 150, isSelected: true, quantity: 1, description: ""),
        Item(name: "Hand Bags", price: 120, isSelected: true, quantity: 1, description: ""),
        Item(name: "Phones", price: 140, isSelected: true, quantity: 1, description: ""),
        Item(name: "Laptop", price: 500, isSelected: false, quantity: 1, description: ""),
        Item(name: "Jewellery", price: 200, isSelected: false, quantity: 1, description: ""),
        Item(name: "Toy", price: 200, isSelected: false, quantity: 1, description: ""),
        Item(name: "Wrist watch", price: 300, isSelected: false, quantity: 1, description: ""),
        Item(name: "Hair", price: 200, isSelected: false, quantity: 1, description: ""),
        Item(name: "Hair care product", price: 150, isSelected: false, quantity: 1, description: "")
    ]
    
    var totalPrice: Int {
        items.filter { $0.isSelected }.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
        VStack(spacing: 0) {
            // Items List
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        ItemRowView(
                            item: $items[index],
                            onToggle: { items[index].isSelected.toggle() },
                            onDecrement: {
                                if items[index].quantity > 1 {
                                    items[index].quantity -= 1
                                }
                            },
                            onIncrement: { items[index].quantity += 1 }
                        )
                        
                        if index < items.count - 1 {
                            Divider()
                                .padding(.leading, 16)
                        }
                    }
                }
            }
            
            // Total Footer
            Button(action: {}) {
                Text("Total: ₦ \(totalPrice)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.green)
            }
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
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
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
