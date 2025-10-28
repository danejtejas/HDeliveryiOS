//
//  OnboardItem.swift
//  HDelivery
//
//  Created by Tejas on 24/10/25.
//


import Foundation

struct OnboardingItem: Codable, Identifiable {
    let id: String
    let name: String
    let img: String
    let description: String
}
