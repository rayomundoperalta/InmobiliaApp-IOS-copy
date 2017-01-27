//
//  PropertyDetailViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/21/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit
import CoreData
import Social

class PropertyDetailViewController: UIViewController {
    
    var propiedad:Propiedades?

    @IBOutlet weak var imagenPropiedad: UIImageView!
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var telefonoLabel: UILabel!
    @IBOutlet weak var municipioLabel: UILabel!
    @IBOutlet weak var entidadLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var valorEstimadoLabel: UILabel!
    @IBOutlet weak var vidaUtilLabel: UILabel!
    @IBOutlet weak var superficieTerrenoLabel: UILabel!
    @IBOutlet weak var superficieConstruidaLabel: UILabel!
    @IBOutlet weak var valorConstruccionLabel: UILabel!
    @IBOutlet weak var proximidadUrbanaLabel: UILabel!
    @IBOutlet weak var tipologiaLabel: UILabel!
    @IBOutlet weak var claseInmuebleLabel: UILabel!
    @IBOutlet weak var latitudLabel: UILabel!
    @IBOutlet weak var CPLabel: UILabel!
    @IBOutlet weak var longitudLabel: UILabel!
    @IBOutlet weak var btnCompartirOutlet: UIButton!
    
    @IBAction func btnBorrar(sender: AnyObject) {
        let managedContext = CoreDataStack.sharedInstance.managedObjectContext
        
        managedContext.deleteObject(propiedad!)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("No pudimos salvar \(error), \(error.userInfo)")
        }
        self.performSegueWithIdentifier("AlonsAuMap", sender: self)
    }
    
    @IBAction func btnCompartir(sender: AnyObject) {
        print("boton compartir")
        do {
            let msg = "InmobiliaApp.peta.mx"
            // Enviar un correo con la información del capturado
            
            let hayFeiz = SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
            let hayTuit = SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
            print("Hay Facebook \(hayFeiz)")
            print("Hay Twiter \(hayTuit)")
            // si existen las dos apps, consultar cual se usa
            if hayFeiz && hayTuit {
                let ac = UIAlertController(title: "Compartir", message: "Compartir la propiedad", preferredStyle: .Alert)
                let btnFeiz = UIAlertAction(title: "Facebook", style:.Default, handler: {(UIAlertAction) in let feizbuc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    feizbuc.setInitialText(msg)
                    //let photoFileName = self.propiedad!.photoFileName!
                    //feizbuc.addImage(UIImage(contentsOfFile: photoFileName))
                    self.presentViewController(feizbuc, animated: true, completion: {
                        self.navigationController?.popViewControllerAnimated(true)})
                })
                let btnTuit = UIAlertAction(title: "Twitter", style: .Default, handler: { (UIAlertAction) in
                    let tuiter = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    tuiter.setInitialText(msg)
                    // tuiter.addImage(laFoto!)
                    self.presentViewController(tuiter, animated: true, completion: {
                        self.navigationController?.popViewControllerAnimated(true)})
                })
                let btnOtro = UIAlertAction(title: "Otro", style: .Default, handler: { (UIAlertAction) in
                    let items:Array<AnyObject> = [msg]
                    let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
                    // esto solo es necesario para el caso del correo
                    avc.setValue("Encontre casa", forKey:"Subject") // jan.zelaznog@gmail.com
                    // vamos a detectar si vemos un ipad o no para arreglar el despliegue
                    // implementar la presentación apropiada para el control ActivityViewControler
                    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
                        self.presentViewController(avc, animated: true, completion: {
                            self.navigationController?.popViewControllerAnimated(true)})
                    } else {
                        let popover = UIPopoverController(contentViewController: avc)
                        popover.presentPopoverFromRect(self.btnCompartirOutlet.frame, inView: self.view, permittedArrowDirections: .Any, animated: true)
                    }
                })
                let btnNoCompartir = UIAlertAction(title: "No compartir", style: .Default, handler: { (UIAlertAction) in
                    self.navigationController?.popViewControllerAnimated(true)})
                ac.addAction(btnFeiz)
                ac.addAction(btnTuit)
                ac.addAction(btnOtro)
                ac.addAction(btnNoCompartir)
                print("mostramos el view controler")
                self.presentViewController(ac, animated: true, completion: nil)
            }
        }
        catch {print("Error al salvar la BD") }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("PropertyDetailViewController -- \(propiedad!.id!)")
        print("\(propiedad!.claseInmueble!) clase de inmueble")
        print("\(propiedad!.cp!) CP")
        print("\(propiedad!.delegacion!) delegacion")
        print("\(propiedad!.entidad!) entidad")
        print("\(propiedad!.direccion!) direccion")
        print("\(propiedad!.telefono!) telefono")
        print(">\(propiedad!.photoFileName!)< photo file name")
        
        imagenPropiedad.image = UIImage(contentsOfFile: (propiedad!.photoFileName!))
        direccionLabel.text = propiedad!.direccion
        telefonoLabel.text = propiedad!.telefono
        municipioLabel.text = "\(propiedad!.nombreMunicipio!)"
        CPLabel.text = "\(propiedad!.cp!)"
        entidadLabel.text = "\(propiedad!.nombreEntidad!)"
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 0;
        
        precioLabel.text = "Precio " + formatter.stringFromNumber(propiedad!.valConcluido!)!
        let porcentaje:Double = (Double(propiedad!.valDesStn!) / Double(propiedad!.valEstimado!)) * 100.0
        valorEstimadoLabel.text = "Valor estimado " + formatter.stringFromNumber(propiedad!.valEstimado!)! + "+-\(porcentaje.format(".0"))%"
        vidaUtilLabel.text = "Vida util \(propiedad!.vidaUtil!) meses"
        superficieTerrenoLabel.text = "Terreno \(propiedad!.superTerreno!) m2"
        superficieConstruidaLabel.text = "Construcción \(propiedad!.superConstruido!) m2"
        valorConstruccionLabel.text = "Valor Const. " + formatter.stringFromNumber(propiedad!.valConst!)!
        proximidadUrbanaLabel.text = "\(propiedad!.nombreProximidadUrbana!)"
        tipologiaLabel.text = "\(propiedad!.nombreTipologia!)"
        claseInmuebleLabel.text = propiedad!.nombreClaseInmueble!
        latitudLabel.text = "Lat \(propiedad!.latitud!)"
        longitudLabel.text = "Lon \(propiedad!.longitud!)"
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

}
