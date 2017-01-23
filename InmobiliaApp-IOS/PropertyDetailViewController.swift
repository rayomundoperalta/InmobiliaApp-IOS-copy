//
//  PropertyDetailViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/21/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit
import CoreData

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
        
        imagenPropiedad.image = UIImage(contentsOfFile: (propiedad!.photoFileName)!)
        direccionLabel.text = propiedad!.direccion
        telefonoLabel.text = propiedad!.telefono
        municipioLabel.text = "\(propiedad!.delegacion!)"
        CPLabel.text = "\(propiedad!.cp!)"
        entidadLabel.text = "\(propiedad!.delegacion!)"
        
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
        proximidadUrbanaLabel.text = "\(propiedad!.proximidadUrbana!)"
        tipologiaLabel.text = "\(propiedad!.tipologia!)"
        //claseInmuebleLabel.text = propiedad!.claseInmueble!
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
