//
//  StringExtention.swift
//  SampleRestaurantBilling
//
//  Created by Guru on 25/12/23.
//

import Foundation

extension Double {
    func roundOff() -> String {
        return String(format: "%.2f", self)
    }
}
