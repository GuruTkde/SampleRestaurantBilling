//
//  ViewController.swift
//  SampleRestaurantBilling
//
//  Created by Guru on 25/12/23.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = BillingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func groupOneInvoiceDidClick(_ sender: UIButton) {
        viewModel.getInvoiceAndTransactionsForGroupOne(isCreditCardPayment: sender.tag == 0)
    }
    
    @IBAction func groupTwoInvoiceDidClick(_ sender: UIButton) {
        viewModel.getInvoiceAndTransactionsForGroupTwo(isCreditCardPayment: sender.tag == 0)
    }
    
    @IBAction func groupThreeInvoiceDidClick(_ sender: UIButton) {
        viewModel.getInvoiceAndTransactionsForGroupThree(isCreditCardPayment: sender.tag == 0)
    }
    
}

