//
//  Constants.swift
//  DeliveryApp
//
//  Created by Gaurav Rajan.
//

import SwiftUI

struct AppConstants {

    // MARK: - Colors
    struct Colors {
        static let primaryBlue = Color(red: 0.24, green: 0.33, blue: 0.67) // #3D5AA3
        static let whatsappGreen = Color(red: 0.15, green: 0.69, blue: 0.31) // #25B051
        static let submitRed = Color(red: 0.91, green: 0.24, blue: 0.24) // #E83E3E
        static let backgroundGray = Color(UIColor.systemGray6)
        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
        static let borderColor = Color.white.opacity(0.3)
        static let cardBackground = Color(UIColor.systemBackground)
    }

    // MARK: - Typography
    struct Typography {
        static let titleFont = Font.system(size: 28, weight: .bold, design: .default)
        static let headingFont = Font.system(size: 22, weight: .semibold, design: .default)
        static let bodyFont = Font.system(size: 16, weight: .regular, design: .default)
        static let buttonFont = Font.system(size: 18, weight: .semibold, design: .default)
        static let captionFont = Font.system(size: 14, weight: .medium, design: .default)
        static let smallFont = Font.system(size: 12, weight: .regular, design: .default)
    }

    // MARK: - Spacing
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: - Layout
    struct Layout {
        static let cornerRadius: CGFloat = 12
        static let buttonHeight: CGFloat = 56
        static let textFieldHeight: CGFloat = 52
        static let shadowRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
    }

    // MARK: - Animation
    struct Animation {
        static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let bouncy = SwiftUI.Animation.spring(response: 0.6, dampingFraction: 0.8)
    }
}

// MARK: - Custom Button Style
struct PrimaryButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color

    init(backgroundColor: Color = AppConstants.Colors.primaryBlue, 
         foregroundColor: Color = .white) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppConstants.Typography.buttonFont)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: AppConstants.Layout.buttonHeight)
            .background(backgroundColor)
            .cornerRadius(AppConstants.Layout.cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(AppConstants.Animation.bouncy, value: configuration.isPressed)
    }
}

// MARK: - Custom TextField Style
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(AppConstants.Typography.bodyFont)
            .padding(AppConstants.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: AppConstants.Layout.cornerRadius)
                    .fill(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppConstants.Layout.cornerRadius)
                            .stroke(AppConstants.Colors.borderColor, lineWidth: AppConstants.Layout.borderWidth)
                    )
            )
    }
}

// MARK: - View Modifiers
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppConstants.Colors.cardBackground)
            .cornerRadius(AppConstants.Layout.cornerRadius)
            .shadow(radius: AppConstants.Layout.shadowRadius)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}

// MARK: - Image Picker Helper
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.dismiss()
        }
    }
}



struct AppSetting {
    struct ColorSetting {
        static let navigationBarBg = Color(red: 0.25, green: 0.38, blue: 0.65)
        static let appBg =  Color(red: 0.25, green: 0.38, blue: 0.65)
            
    }
    
    struct GoogleKeySetting {
//        static let mapKey = "AIzaSyBNg2knQi55GDSz7AewCplxQ6mYwklUwsw"
        static let mapKey = "AIzaSyCH7DT_fligrk_4Y3VjMrmHsdyYVuP-_Wg"
    }
    
    struct URLS {
        static let baseURL = "https://hapihyper.com/admin/api/"
    }
}

