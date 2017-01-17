//
//  CapturaDeDatosNumericosViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/11/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit

class CapturaDeDatosNumericosViewController: UIViewController {
    
    var estadoSeleccionado: String = ""
    var claveDeMunicipioSeleccionado:String = ""
    var municipioSeleccionado:String = ""

    func doStringContainsNumber( _string : String) -> Bool{
        
        let numberRegEx  = "[0-9]+"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluateWithObject(_string)
        
        return containsNumber
    }
    
    func muestraAlerta(conTitulo titulo:String, conMensaje msg:String, enElCampo dato:UITextField) {
        let alert = UIAlertController(title: titulo,
                                      message: msg,
                                      preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK",
                                       style: .Default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        dato.text = ""
        })
        
        alert.addAction(okAction)
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }
    
    
    func muestraAlerta(conTitulo titulo:String, conMensaje msg:String) {
        let alert = UIAlertController(title: titulo,
                                      message: msg,
                                      preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .Default,
                                     handler: { (action:UIAlertAction) -> Void in
        })
        
        alert.addAction(okAction)
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }
    
    @IBOutlet weak var labelCP: UILabel!
    @IBOutlet weak var datoCP: UITextField!
    @IBAction func capturaCP(sender: AnyObject) {
        if !doStringContainsNumber(datoCP.text!) {
            muestraAlerta(conTitulo: "CP", conMensaje: "solo acepta numeros enteros", enElCampo: datoCP)
        }
        ValoresGlobales.sharedInstance.CP = datoCP.text!
    }
    
    @IBOutlet weak var labelVidaUtil: UILabel!
    @IBOutlet weak var datoVidaUtil: UITextField!
    @IBAction func capturaVidaUtil(sender: AnyObject) {
        if !doStringContainsNumber(datoVidaUtil.text!) {
            muestraAlerta(conTitulo:"Vida útil", conMensaje: "solo acepta numeros enteros", enElCampo: datoVidaUtil)
        }
        ValoresGlobales.sharedInstance.vidaUtil = datoVidaUtil.text!
    }
    
    @IBOutlet weak var labelSuperficieTerreno: UILabel!
    @IBOutlet weak var datoSuperficieTerreno: UITextField!
    @IBAction func capturaSuperficieTerreno(sender: AnyObject) {
        if !doStringContainsNumber(datoSuperficieTerreno.text!) {
            muestraAlerta(conTitulo:"Superficie terreno", conMensaje: "solo acepta numeros enteros", enElCampo: datoSuperficieTerreno)
        }
        ValoresGlobales.sharedInstance.superficieTerreno = datoSuperficieTerreno.text!
    }

    @IBOutlet weak var labelSuperficieConstruida: UILabel!
    @IBOutlet weak var datoSuperficieConstruida: UITextField!
    @IBAction func capturaSuperficieConstruida(sender: AnyObject) {
        if !doStringContainsNumber(datoSuperficieConstruida.text!) {
            muestraAlerta(conTitulo:"Superficie Construida", conMensaje: "solo acepta numeros enteros", enElCampo: datoSuperficieConstruida)
        }
        ValoresGlobales.sharedInstance.superficieConstruida = datoSuperficieConstruida.text!
    }
    
    @IBOutlet weak var labelValorConstrucción: UILabel!
    @IBOutlet weak var datoValorConstrucción: UITextField!
    @IBAction func capturaValorConstrucción(sender: AnyObject) {
        if !doStringContainsNumber(datoValorConstrucción.text!) {
            muestraAlerta(conTitulo:"Valor construcción", conMensaje: "solo acepta numeros enteros", enElCampo: datoValorConstrucción)
        }
        ValoresGlobales.sharedInstance.valorConstrucción = datoValorConstrucción.text!
    }
    
    @IBOutlet weak var labelPrecio: UILabel!
    @IBOutlet weak var datoPrecio: UITextField!
    @IBAction func capturaPrecio(sender: AnyObject) {
        if !doStringContainsNumber(datoPrecio.text!) {
            muestraAlerta(conTitulo:"Precio", conMensaje: "solo acepta numeros enteros", enElCampo: datoPrecio)
        }
        ValoresGlobales.sharedInstance.precio = datoPrecio.text!
    }
    
    @IBOutlet weak var datoDirección: UITextField!
    @IBAction func capturaDirección(sender: AnyObject) {
        ValoresGlobales.sharedInstance.dirección = datoDirección.text!
    }
    
    @IBOutlet weak var datoTelefono: UITextField!
    @IBAction func capturaTelefono(sender: AnyObject) {
        if !doStringContainsNumber(datoTelefono.text!) {
            muestraAlerta(conTitulo:"Telefono", conMensaje: "solo acepta numeros enteros", enElCampo: datoTelefono)
        }
        ValoresGlobales.sharedInstance.teléfono = datoTelefono.text!
    }
    
    @IBAction func botonSiguente(sender: AnyObject) {
        print("boton siguiente")
        if datoCP.text == "" || datoVidaUtil.text == "" || datoSuperficieTerreno.text == "" || datoSuperficieConstruida.text == "" || datoValorConstrucción.text == "" || datoPrecio.text == "" || datoDirección.text == "" || datoTelefono.text == "" {
            muestraAlerta(conTitulo:"Faltan datos", conMensaje: "todos los campos son obligatorios")
        } else {
            self.performSegueWithIdentifier("PasemosACapturaDeCategorias", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ValoresGlobales.sharedInstance.estadoSeleccionado = self.estadoSeleccionado
        ValoresGlobales.sharedInstance.claveDeMunicipioSeleccionado = self.claveDeMunicipioSeleccionado
        ValoresGlobales.sharedInstance.municipioSeleccionado = self.municipioSeleccionado
        datoCP.borderStyle = .RoundedRect
        datoCP.placeholder = "00000"
        datoVidaUtil.borderStyle = .RoundedRect
        datoVidaUtil.placeholder = "meses"
        datoSuperficieTerreno.borderStyle = .RoundedRect
        datoSuperficieTerreno.placeholder = "m2"
        datoSuperficieConstruida.borderStyle = .RoundedRect
        datoSuperficieConstruida.placeholder = "m2"
        datoValorConstrucción.borderStyle = .RoundedRect
        datoValorConstrucción.placeholder = "pesos"
        datoPrecio.borderStyle = .RoundedRect
        datoPrecio.placeholder = "pesos"
        datoDirección.borderStyle = .RoundedRect
        datoDirección.placeholder = "Dirección"
        datoTelefono.borderStyle = .RoundedRect
        datoTelefono.placeholder = "Telefóno"
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
