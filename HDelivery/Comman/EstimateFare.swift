//
//  EstimateFare.swift
//  
//
//  Created by Tejas on 07/11/25.
//


import UIKit
import CoreLocation

class EstimateFare: NSObject {
    
    /// <#Description#>
    /// - Parameters:
    ///   - startLocation: startLocation description
    ///   - endLocation: endLocation description
   
    /// - Returns: Int for estmate price and string for estimate Distance
  static  func calculateEstmatePrice(startLocation : CLLocation,  endLocation : CLLocation, itemPrice : Int ) -> (Int, String) {
        var price: Double = 0.0
        var ppk = "0"
        var ppm = "0"
        var sf = "0"
        var taskRate = "0"
        var taskDefaultTime = "0"
       
        var estimateDistance: String = "0"

      
        
        do {
            let jobType =  try StorageManager.shared.getJobType()
            let appSetting = try StorageManager.shared.getAppConfig()
            var results = CLLocationDistance(0)
            let start = startLocation
            let end = endLocation
            
            
            results = start.distance(from: end) // distance in meters
            
            estimateDistance = String(format: "%.2f", results / 1000)
            ppk = jobType?.feePerMinute  ?? "0"
            ppm = jobType?.feePerKilometer ?? "0"
            sf = jobType?.startFare ?? "0"
            taskRate = jobType?.taskRate ?? "0"
            taskDefaultTime = jobType?.taskDefaultTime ?? "0"
            
            let distanceKm = results / 1000
            let fareSpeed = Double(appSetting?.estimateFareSpeed ??  "0") ?? 1.0
            
            
            let startFare = Double(sf) ?? 0.0
            let perMinuteRate = Double(ppm) ?? 0.0
            let perKmRate = Double(ppk) ?? 0.0
            let taskRateValue = Double(taskRate) ?? 0.0
            let taskDefaultTimeValue = Double(taskDefaultTime) ?? 0.0
            let fareSpeedValue = Double(fareSpeed)

            let distanceCost = distanceKm * perKmRate
            let timeCost = (distanceKm / fareSpeedValue) * 60 * perMinuteRate
            let taskCost = taskRateValue * taskDefaultTimeValue

            price = startFare + distanceCost + timeCost + taskCost + Double(itemPrice)

            
            
            let x = Int(round(price))
            let t = ((x + 49) / 50) * 50
            print("double: \(price)")
            print("Estimate Cost: \(x)")
            print("Round Cost: \(t)")
            return (t,estimateDistance)
            
        }
        catch{
            print("error == \(error.localizedDescription)")
            return (0, estimateDistance)
        }
       
    }
}

