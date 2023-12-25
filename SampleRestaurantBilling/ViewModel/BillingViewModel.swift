//
//  BillingViewModel.swift
//  SampleRestaurantBilling
//
//  Created by Guru on 25/12/23.
//

import Foundation

class BillingViewModel {
    
    var products: ProductModel!
    var groupOne: GroupOne!
    var groupTwo: GroupDataModel!
    var groupThree: GroupDataModel!
    let invoiceUtility: InvoiceUtility!
    let taxPercentage = 8.0 // modify based on requirement
    
    init() {
        invoiceUtility = .init()
        bindData()
    }
    
    func bindData() {
        let tea = ProductDetails.init(name: Constants.tea.rawValue, taxPercentage: taxPercentage, totalPrice: Constants.tea.price)
        let bigBrekkie = ProductDetails.init(name: Constants.bigBrekkie.rawValue, taxPercentage: taxPercentage, totalPrice: Constants.bigBrekkie.price)
        let bruchetta = ProductDetails.init(name: Constants.bruchetta.rawValue, taxPercentage: taxPercentage, totalPrice: Constants.bruchetta.price)
        let poachedEggs = ProductDetails.init(name: Constants.poachedEggs.rawValue, taxPercentage: taxPercentage, totalPrice: Constants.poachedEggs.price)
        let gardenSalad = ProductDetails.init(name: Constants.gardenSalad.rawValue, taxPercentage: taxPercentage, totalPrice: Constants.gardenSalad.price)
        let coffee = ProductDetails.init(name: Constants.coffee.rawValue, taxPercentage: taxPercentage, totalPrice: Constants.coffee.price)
        let soda = ProductDetails.init(name: Constants.soda.rawValue, taxPercentage: taxPercentage, totalPrice: Constants.soda.price)
        
        products = ProductModel.init(tea: tea,
                                     bigBrekkie: bigBrekkie,
                                     soda: soda,
                                     bruchetta: bruchetta,
                                     poachedEggs: poachedEggs,
                                     coffee: coffee,
                                     gardenSalad: gardenSalad)
        bindGroupOneData()
        bindGroupTwoData()
        bindGroupThreeData()
    }
    
    
    func bindGroupOneData() {
        let firstPersonOrderedItems  = [FoodItems.init(product: products.tea, count: 1),
                                        FoodItems.init(product: products.bigBrekkie, count: 1)]
        let secondPersonOrderedItems = [FoodItems.init(product: products.bigBrekkie, count: 1),
                                        FoodItems.init(product: products.coffee, count: 1)]
        let thirdPersonOrderedItems  = [FoodItems.init(product: products.bruchetta, count: 1),
                                        FoodItems.init(product: products.poachedEggs, count: 1),
                                        FoodItems.init(product: products.soda, count: 1)]
        
        groupOne = GroupOne.init(members: [Person.init(name: "First Person", products: firstPersonOrderedItems),
                                           Person.init(name: "Second Person", products: secondPersonOrderedItems),
                                           Person.init(name: "Third Person", products: thirdPersonOrderedItems)])
    }
    
    func bindGroupTwoData() {
        groupTwo = GroupDataModel.init(products: [FoodItems.init(product: products.tea, count: 1),
                                                  FoodItems.init(product: products.coffee, count: 3),
                                                  FoodItems.init(product: products.soda, count: 1),
                                                  FoodItems.init(product: products.bigBrekkie, count: 3),
                                                  FoodItems.init(product: products.poachedEggs, count: 1),
                                                  FoodItems.init(product: products.gardenSalad, count: 1)])
    }
    
    func bindGroupThreeData() {
        groupThree = GroupDataModel.init(products: [FoodItems.init(product: products.tea, count: 2),
                                                    FoodItems.init(product: products.coffee, count: 3),
                                                    FoodItems.init(product: products.soda, count: 2),
                                                    FoodItems.init(product: products.bruchetta, count: 5),
                                                    FoodItems.init(product: products.bigBrekkie, count: 5),
                                                    FoodItems.init(product: products.poachedEggs, count: 2),
                                                    FoodItems.init(product: products.gardenSalad, count: 3)])
    }
    
    func getInvoiceAndTransactionsForGroupOne(isCreditCardPayment: Bool) {
        for person in groupOne.members {
            print("\n\n\n ****************** \(person.name) Invoice *******************\n")
            let billAmount = invoiceUtility.generateInvoice(model: person.products,
                                                            groupId: 1,
                                                            isCreditCardPayament: isCreditCardPayment)
            print("\n ***************** \(person.name) Transaction ******************\n")
            invoiceUtility.payBill(groupId: 1,
                                   billAmount: billAmount,
                                   paidAmount: 30)
        }
    }
    
    func getInvoiceAndTransactionsForGroupTwo(isCreditCardPayment: Bool) {
        print(" Group Two Invoice \n")
        let billAmount = invoiceUtility.generateInvoice(model: groupTwo.products,
                                                        groupId: 2,
                                                        isCreditCardPayament: isCreditCardPayment,
                                                        discountPercentage: 10)
        print("\n Group Two Transaction \n")
        invoiceUtility.payBill(groupId: 2,
                               billAmount: billAmount,
                               paidAmount: 70)
    }
    
    
    func getInvoiceAndTransactionsForGroupThree(isCreditCardPayment: Bool) {
        print(" Group Three Invoice \n")
        var billAmount = invoiceUtility.generateInvoice(model: groupTwo.products,
                                                        groupId: 3,
                                                        isCreditCardPayament: isCreditCardPayment,
                                                        discount: 25.0,
                                                        initialTab: 50.0)
        print("\n Group Three Transaction \n")
        let amountPerPerson = billAmount/7
        for _ in 0..<7 {
            invoiceUtility.payBill(groupId: 3,
                                   billAmount: billAmount,
                                   paidAmount: amountPerPerson)
            billAmount -= amountPerPerson
        }
    }
}
