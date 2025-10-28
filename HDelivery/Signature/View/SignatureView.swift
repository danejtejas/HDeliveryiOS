//
//  SignatureView.swift
//  HDelivery
//
//  Created by Tejas on 16/10/25.
//

import SwiftUI
import PencilKit
import ToastSwiftUI

struct SignatureScreen: View {
    @State private var receiverName: String = ""
    @State private var canvasView = PKCanvasView()
    @State private var receiverImage: UIImage? = nil
    @State private var showImagePicker = false
    
    @StateObject private var viewModel: SignatureViewModel = .init()
    var tripData : TripHistory?
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Title Bar
            Text("Signature")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Receiver Name Field
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Receiver Name")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Enter name", text: $viewModel.username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Signature Pad
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Receiver Signature")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        SignatureView(canvasView: $canvasView)
                            .frame(height: 200)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5)))
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                canvasView.drawing = PKDrawing()
                            }) {
                                Label("Clear", systemImage: "xmark")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    // Upload Receiver Photo
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Upload Receiver Photo")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            showImagePicker = true
                        }) {
                            if let receiverImage = receiverImage {
                                Image(uiImage: receiverImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(10)
                            } else {
                                VStack {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                    Text("Take Photo")
                                        .foregroundColor(.gray)
                                }
                                .frame(width: 150, height: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [5]))
                                )
                            }
                        }
                    }
                    
                    // Submit Button
                    Button(action: handleSubmit) {
                        Text("Submit")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading  ) {
                Button(action: {
                   
                }) {
                    Image(systemName: "back")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            
            // Title Customization
            ToolbarItem(placement: .principal) {
                Text("Signature")
                    .foregroundColor(.white)  // Title color set to white
                    .font(.system(size: 22, weight: .medium))
            }
            
            
        }
        .navigationTitle("Signature")
        .navigationBarBackButtonHidden()
        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $receiverImage)
        }
        .toast(isPresenting: $viewModel.showAlert, message: viewModel.message ?? "")
        .overlay {
            if viewModel.isLoading {
                LoadView()
            }
        }
        
    }
    
    func handleSubmit() {
        // Convert signature to image if needed
        let signatureImage = canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)
        viewModel.receiverSignature =  signatureImage.toBase64()
        viewModel.image = receiverImage?.toBase64() ?? ""
        viewModel.tripId = tripData?.id ?? ""
        viewModel.transactionId = "dfasfdfajlfda"
        print("✅ Submitted: \(receiverName)")
        
        Task{
            await viewModel.submit()
        }
    }
}

// MARK: - SignatureView (PencilKit)
struct SignatureView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .white
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

