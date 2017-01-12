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

    @IBOutlet weak var labelCP: UILabel!
    @IBOutlet weak var datoCP: UITextField!
    @IBAction func capturaCP(sender: AnyObject) {
    }
    
    @IBOutlet weak var labelVidaUtil: UILabel!
    @IBOutlet weak var datoVidaUtil: UITextField!
    @IBAction func capturaVidaUtil(sender: AnyObject) {
    }
    
    @IBOutlet weak var labelSuperficieTerreno: UILabel!
    @IBOutlet weak var datoSuperficieTerreno: UITextField!
    @IBAction func capturaSuperficieTerreno(sender: AnyObject) {
    }

    @IBOutlet weak var labelSuperficieConstruida: UILabel!
    @IBOutlet weak var datoSuperficieConstruida: UITextField!
    @IBAction func capturaSuperficieConstruida(sender: AnyObject) {
    }
    
    @IBOutlet weak var labelValorConstrucción: UILabel!
    @IBOutlet weak var datoValorConstrucción: UITextField!
    @IBAction func capturaValorConstrucción(sender: AnyObject) {
    }
    
    @IBOutlet weak var labelPrecio: UILabel!
    @IBOutlet weak var datoPrecio: UITextField!
    @IBAction func capturaPrecio(sender: AnyObject) {
    }
    
    @IBOutlet weak var datoDirección: UITextField!
    @IBAction func capturaDirección(sender: AnyObject) {
    }
    
    @IBOutlet weak var datoTelefono: UITextField!
    @IBAction func capturaTelefono(sender: AnyObject) {
    }
    
    @IBAction func botonSiguente(sender: AnyObject) {
        self.performSegueWithIdentifier("PasemosACapturaDeCategorias", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
