//
//  BillingDataModel.swift
//  SampleRestaurantBilling
//
//  Created by Guru on 25/12/23.
//

import Foundation

typealias priceAndTaxAmount = (price: Double,
                               tax: Double)

enum Constants: String {
    case tea = "Tea"
    case bigBrekkie = "Big Brekkie"
    case bruchetta = "Bruchetta"
    case poachedEggs = "Poached Eggs"
    case coffee = "Coffee"
    case soda = "Soda"
    case gardenSalad = "Garden Salad"
    
    var price: Double {
        switch self {
        case .tea: return 3.0
        case .bigBrekkie: return 16.0
        case .bruchetta: return 8.0
        case .poachedEggs: return 12.0
        case .coffee: return 5.0
        case .soda: return 4.0
        case .gardenSalad: return 10.0
        }
    }
}

struct ProductDetails {
    let name: String
    let price: Double?
    let taxAmount: Double?
    let taxPercentage: Double
    let totalPrice: Double
    
    init(name: String,
         price: Double? = nil,
         taxAmount: Double? = nil,
         taxPercentage: Double,
         totalPrice: Double)
    {
        let priceAndTaxAmount = ProductDetails.getPriceFromTotalAmount(price: totalPrice,
                                                                     percentage: taxPercentage)
        self.name = name
        self.price = priceAndTaxAmount.price
        self.taxAmount = priceAndTaxAmount.tax
        self.taxPercentage = taxPercentage
        self.totalPrice = totalPrice
    }
    
    static func getPriceFromTotalAmount(price: Double,
                                        percentage: Double) -> priceAndTaxAmount
    {
        let taxAmount = (price/100.0) * percentage
        let priceAmount = price - taxAmount
        return (priceAmount,taxAmount)
    }
}


struct ProductModel {
    let tea: ProductDetails
    let bigBrekkie: ProductDetails
    let soda: ProductDetails
    let bruchetta: ProductDetails
    let poachedEggs: ProductDetails
    let coffee: ProductDetails
    let gardenSalad: ProductDetails
    
    init(tea: ProductDetails,
         bigBrekkie: ProductDetails,
         soda: ProductDetails,
         bruchetta: ProductDetails,
         poachedEggs: ProductDetails,
         coffee: ProductDetails,
         gardenSalad: ProductDetails) {
        self.tea = tea
        self.bigBrekkie = bigBrekkie
        self.soda = soda
        self.bruchetta = bruchetta
        self.poachedEggs = poachedEggs
        self.coffee = coffee
        self.gardenSalad = gardenSalad
    }
}

struct GroupOne {
    let members: [Person]
}

struct Person {
    let name: String
    let products: [FoodItems]
}
struct FoodItems {
    let product: ProductDetails
    let count: Int
}

struct GroupDataModel {
    let products: [FoodItems]
}
