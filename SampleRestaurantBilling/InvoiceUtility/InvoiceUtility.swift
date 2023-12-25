//
//  InvoiceUtility.swift
//  SampleRestaurantBilling
//
//  Created by Guru on 25/12/23.
//

import Foundation

class InvoiceUtility {
        
    func generateInvoice(model: [FoodItems],
                         groupId: Int,
                         isCreditCardPayament: Bool,
                         discount: Double? = nil,
                         initialTab: Double? = nil,
                         discountPercentage: Double? = nil) -> Double {
        addHeaderText()
        var totalAmount = 0.0
        var surcharge = 0.0
        var discount = discount ?? 0.0
        let initialTab = initialTab ?? 0.0
        for i in model {
            let totalPrice = (i.product.totalPrice)*Double(i.count)
            totalAmount += totalPrice
            textFormatting(groupId: String(groupId),
                           item: i.product.name,
                           price: i.product.price ?? 0.0,
                           tax: i.product.taxAmount ?? 0.0,
                           Numbers: i.count,
                           total: totalPrice)
        }
        if isCreditCardPayament {
            surcharge = (totalAmount/100.0) * 1.2
        }
        if let discountPercent = discountPercentage {
            discount = (totalAmount/100.0) * discountPercent
        }
        let total = totalAmount + surcharge - (discount + initialTab)
        print(" Surcharge: \(surcharge.roundOff())\n Discount: \((discount + initialTab).roundOff())\n Total: \(total.roundOff())")
        return total

    }
    
    func payBill(groupId: Int, billAmount: Double, paidAmount: Double) {
        let returned = paidAmount - billAmount > 0 ? paidAmount - billAmount : 0
        let remaining = billAmount - paidAmount > 0 ? billAmount - paidAmount : 0
        print("Group id: \(groupId)  Paid: $\(paidAmount.roundOff())  Returned: $\(returned.roundOff())  Remaing: $\(remaining.roundOff())")
    }
    
    func textFormatting(groupId: String, item: String, price: Double, tax: Double, Numbers: Int, total: Double) {
        let columnDefaultPadLength = 15

        //Define the string to display a line of our data
        let dataString = groupId.padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + item.padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + String(price).padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + String(tax).padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + String(Numbers).padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) +
            String(total).padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0)
        print("\(dataString)\n")
    }
    
    func addHeaderText() {
        let columnDefaultPadLength = 15

        //Define the header string
        let headerString = "Group Id".padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + "Item".padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + "price".padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + "tax".padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) + "No's".padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0) +
        "total price".padding(toLength: columnDefaultPadLength, withPad: " ", startingAt: 0)
        

        //Define the line separator
        let lineString = "".padding(toLength: headerString.count, withPad: "-", startingAt: 0)
        print("\(headerString)\n\(lineString)")

    }
}
