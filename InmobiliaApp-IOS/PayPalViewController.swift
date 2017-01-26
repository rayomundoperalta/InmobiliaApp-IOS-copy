//
//  PayPalViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/23/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit

class PayPalViewController: UIViewController, PayPalPaymentDelegate {

    var payPalConfig = PayPalConfiguration()
    
    var enviroment:String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != enviroment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
    var acceptCreditCards:Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        payPalConfig.acceptCreditCards = acceptCreditCards
        payPalConfig.merchantName = "Industrias PETA S de RL MI"
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "http://peta.mx")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "http://peta.mx")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0]
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        PayPalMobile.preconnectWithEnvironment(enviroment)
        
        // Process Payment once the pay button is clicked.
        
        let item1 = PayPalItem(name: "Paquete de 3 avaluos", withQuantity: 1, withPrice: NSDecimalNumber(string: "250.00"), withCurrency: "MXN", withSku: "PETA 00001")
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "35.20")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "MXN", shortDescription: "3 estimaciones", intent: .Sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController!, animated: true, completion: nil)
        }
        else {
            print("Payment not processable: \(payment)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
        print("PayPal Payment Cancelled")
        self.performSegueWithIdentifier("AlonsAuMap", sender: self)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController, didCompletePayment completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismissViewControllerAnimated(true, completion: { () -> Void in
            // send completed confirmation to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            print("----------------------------")
            
            print("currencyCode \(completedPayment.currencyCode)")
            print("amount       \(completedPayment.amount)")
            print("description  \(completedPayment.description)")
            print("intent       \(completedPayment.intent)")
            print("processable  \(completedPayment.processable)")
            print("Display      \(completedPayment.localizedAmountForDisplay)")
            
            print("--> \(completedPayment) <--")
            let response = completedPayment.confirmation["response"]!
            print("create_time \(response["create_time"])")
            print("id          \(response["id"])")
            print("intent      \(response["intent"])")
            print("state       \(response["state"])")
            // ------------->>  Es aqui cuando ya terminó la transacción, regresamos al mapa
            
            self.performSegueWithIdentifier("AlonsAuMap", sender: self)
        })
    }

}
