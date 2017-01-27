//
//  PayPalViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/23/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit
import CoreData

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
            
            let managedContext = CoreDataStack.sharedInstance.managedObjectContext
            
            var entity = NSEntityDescription.entityForName("EstimacionesCompradas", inManagedObjectContext: managedContext)
            
            let estimacionesCompradas = EstimacionesCompradas(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            estimacionesCompradas.setValue("\(completedPayment.currencyCode)", forKey: "currencyCode")
            estimacionesCompradas.setValue("\(completedPayment.amount)", forKey: "amount")
            estimacionesCompradas.setValue("\(completedPayment.description)", forKey: "descripcion")
            estimacionesCompradas.setValue("\(completedPayment.intent)", forKey: "intent")
            estimacionesCompradas.setValue("\(completedPayment.processable)", forKey: "processable")
            estimacionesCompradas.setValue("\(completedPayment.localizedAmountForDisplay)", forKey: "display")
            let response = completedPayment.confirmation["response"]!
            estimacionesCompradas.setValue("\(response["create_time"])", forKey: "fechaCompra")
            estimacionesCompradas.setValue("\(response["id"])", forKey: "payKey")
            estimacionesCompradas.setValue("\(response["state"])", forKey: "state")
            
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
            
            print("create_time \(response["create_time"])")
            print("id          \(response["id"])")
            print("intent      \(response["intent"])")
            print("state       \(response["state"])")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            // ------------->>  Es aqui cuando ya terminó la transacción, tenemos que actualizar el numero de estimaciones disponibles
            
            var registros:Int = 0
            var arrayEstimaciones:[Estimaciones]?
            let fetchRequest = NSFetchRequest(entityName: "Estimaciones")
            do {
                let results = try managedContext.executeFetchRequest(fetchRequest)
                arrayEstimaciones = results as? [Estimaciones]
                if arrayEstimaciones != nil {
                    registros = arrayEstimaciones!.count
                } else {
                    registros = 0
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            print("\(registros) registros de estimaciones")
            
            entity = NSEntityDescription.entityForName("Estimaciones", inManagedObjectContext: managedContext)
            
            if registros == 0 { // creamos un registro
                let estimaciones = Estimaciones(entity: entity!, insertIntoManagedObjectContext: managedContext)
                estimaciones.setValue(3, forKey: "estimaciones")
            } else {
                // No logramos hacer que funcionara el update, por lo tanto lo hacemos leyendo borrando e insertando el 
                // objeto costoso pero funciona como quiero
                
                var aux = (arrayEstimaciones![0].estimaciones as! Int)
                aux = aux + 3
                managedContext.deleteObject(arrayEstimaciones![0])
                let estimaciones = Estimaciones(entity: entity!, insertIntoManagedObjectContext: managedContext)
                print("nuevas estimaciones \(aux)")
                estimaciones.setValue(aux, forKey: "estimaciones")
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            self.performSegueWithIdentifier("AlonsAuMap", sender: self)
        })
    }

}
