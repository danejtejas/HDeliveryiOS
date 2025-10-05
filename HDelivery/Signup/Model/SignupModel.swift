//
//  SignupModel.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//

import Foundation
import SwiftUI
import _PhotosUI_SwiftUI


struct SignupModel {
    
     var fullName = ""
     var phone = ""
     var email = ""
     var password = ""
     var address = ""
     var state = ""
     var city = ""
     var postCode = ""
     var selectedPhoto: PhotosPickerItem? = nil
     var avatarImage: Image? = nil
     var imageData: String = ""
    var country : String = ""
    var account : String = ""
    
}
