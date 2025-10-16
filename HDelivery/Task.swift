//
//  Task.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//


import SwiftUI



// MARK: - Models
struct Ride: Identifiable {
    let id: Int
    let date: Date
    let type: String
    let fromAddress: String
    let toAddress: String
    let trip: String
    let ride: String
    let payment: String
    let amount: Double
}


let rides = [
    Ride(id: 375, date: Date(timeIntervalSince1970: 1727086468),
         type: "move my parcel",
         fromAddress: "4VAIVG+CCQM, Sme EWS Twp, Bhestan, Surat, Karadva, Gujarat 394210, India",
         toAddress: "Gita Mandir, Ahmedabad, Gujarat, India",
         trip: "0.0Km(1 minutes)",
         ride: "0",
         payment: "By Cash",
         amount: -1897.50),
    
    Ride(id: 373, date: Date(timeIntervalSince1970: 1725448538),
         type: "move my parcel",
         fromAddress: "Madhar Mall, Thakkarbapa Nagar Road, Nandanvan Society, Thakkarbapanagar, Ahmedabad, Gujarat, India",
         toAddress: "Rajhans Cinemas, New India Colony, Nikol, Ahmedabad, Gujarat, India",
         trip: "0.1Km(1 minutes)",
         ride: "0",
         payment: "By Cash",
         amount: 0),
    
    Ride(id: 372, date: Date(timeIntervalSince1970: 1725448309),
         type: "move my parcel",
         fromAddress: "Sample Address",
         toAddress: "Sample Destination",
         trip: "5.2Km(15 minutes)",
         ride: "0",
         payment: "By Cash",
         amount: -315.00)
]





