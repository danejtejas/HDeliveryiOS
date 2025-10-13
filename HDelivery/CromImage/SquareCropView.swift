//
//  SquareCropView..swift
//  HDelivery
//
//  Created by Tejas on 13/10/25.
//


import SwiftUI

struct SquareCropView: View {
    @Environment(\.dismiss) private var dismiss
    
    let image: UIImage
    var onCropped: (UIImage) -> Void
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    // For visual feedback
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            // Background
            Color.black.ignoresSafeArea()
            
            GeometryReader { geo in
                let size = geo.size.width
                
                ZStack {
                    // Cropping image
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .scaleEffect(scale)
                        .offset(offset)
                        .clipped()
                        .gesture(
                            SimultaneousGesture(
                                DragGesture()
                                    .onChanged { value in
                                        isDragging = true
                                        offset = CGSize(
                                            width: lastOffset.width + value.translation.width,
                                            height: lastOffset.height + value.translation.height
                                        )
                                    }
                                    .onEnded { _ in
                                        isDragging = false
                                        lastOffset = offset
                                    },
                                
                                MagnificationGesture()
                                    .onChanged { value in
                                        scale = lastScale * value
                                    }
                                    .onEnded { _ in
                                        lastScale = max(1.0, min(scale, 5.0)) // Clamp zoom
                                        scale = lastScale
                                    }
                            )
                        )
                        .animation(.easeInOut(duration: 0.2), value: isDragging)
                    
                    // Dimmed overlay outside crop area
                    Rectangle()
                        .fill(Color.black.opacity(0.6))
                        .mask(
                            CropMask(size: size)
                                .fill(style: FillStyle(eoFill: true))
                        )
                        .allowsHitTesting(false)
                    
                    // Square crop frame
                    Rectangle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: size, height: size)
                        .allowsHitTesting(false)
                }
                .frame(width: size, height: size)
                .clipped()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Bottom action bar
            VStack {
                Spacer()
                
                HStack(spacing: 25) {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                            .fontWeight(.medium)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 32)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Capsule())
                    }
                    
                    Button(action: { cropAndReturn() }) {
                        Text("Use Photo")
                            .fontWeight(.semibold)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 32)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
        .statusBar(hidden: true)
    }
    
    // MARK: - Cropping Logic
    private func cropAndReturn() {
        let renderer = ImageRenderer(content:
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .scaleEffect(scale)
                .offset(offset)
                .frame(width: 100, height: 100)
                .clipped()
        )
        
        if let uiImage = renderer.uiImage {
            onCropped(uiImage)
        }
        
        dismiss()
    }
}

// MARK: - Mask for Dim Background Outside Crop
struct CropMask: Shape {
    let size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(rect)
        let squareRect = CGRect(
            x: (rect.width - size) / 2,
            y: (rect.height - size) / 2,
            width: size,
            height: size
        )
        path.addRect(squareRect)
        return path
    }
}

