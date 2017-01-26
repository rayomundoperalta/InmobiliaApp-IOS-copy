//
//  MunicipiosTableViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/5/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit

class MunicipiosTableViewController: UITableViewController {
    
    var estadoSeleccionado: String = ""
    
    var listaMunicipios: [String] = []
    
    var VGSI = ValoresGlobales.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        listaMunicipios = CatalogoEstadosMunicipios.sharedInstance.catalogoEdosMun[estadoSeleccionado]!.keys.sort(<)
        print("\(listaMunicipios)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaMunicipios.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("munCell", forIndexPath: indexPath) as! MunicipioTableViewCell

        cell.municipio.text = listaMunicipios[indexPath.row]

        return cell
    }
    
    var claveDeMunicipioSeleccionado:String = ""
    var municipioSeleccionado:String = ""
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Municipio seleccionado \(listaMunicipios[indexPath.row])")
        VGSI.nombreMunicipio = listaMunicipios[indexPath.row]
        municipioSeleccionado = listaMunicipios[indexPath.row]
        claveDeMunicipioSeleccionado = CatalogoEstadosMunicipios.sharedInstance.catalogoEdosMun[estadoSeleccionado]![municipioSeleccionado]!
        print("Clave del municipio seleccionado \(claveDeMunicipioSeleccionado)")
        self.performSegueWithIdentifier("PasemosACapturaDeDatosNumericos", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PasemosACapturaDeDatosNumericos" {
            let controller = (segue.destinationViewController as! CapturaDeDatosNumericosViewController)
            controller.estadoSeleccionado = sender!.estadoSeleccionado
            controller.municipioSeleccionado = sender!.municipioSeleccionado
            controller.claveDeMunicipioSeleccionado = sender!.claveDeMunicipioSeleccionado
        }
    }
    

}
