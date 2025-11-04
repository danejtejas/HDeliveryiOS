//
//  UIImageExtension.swift
//  HDelivery
//
//  Created by Tejas on 13/10/25.
//

import UIKit
import SwiftUI

extension UIImage {
    /// Converts UIImage to a Base64 encoded string (JPEG)
    func toBase64(compressionQuality: CGFloat = 0.7) -> String? {
//        guard let imageData = self.jpegData(compressionQuality: compressionQuality) else {
//            return nil
//        }
//        return imageData.base64EncodedString()
        
        guard let imageData = self.pngData() else {
            return nil
        }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    static func fromBase64(_ base64String: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64String),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    
}
