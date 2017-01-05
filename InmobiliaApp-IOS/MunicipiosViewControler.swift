//
//  MunicipiosViewControler.swift
//  CaEdMu
//
//  Created by Raymundo Peralta on 12/27/16.
//  Copyright © 2016 Industrias Peta. All rights reserved.
//

import UIKit

class MunicipiosViewControler: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var estadoSeleccionado: String = ""
    
    var listaMunicipios : [String] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "munCell")
        listaMunicipios = CatalogoEstadosMunicipios.sharedInstance.catalogoEdosMun[estadoSeleccionado]!.keys.sort(<)
        print("\(listaMunicipios)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaMunicipios.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("munCell")! as UITableViewCell
        cell.textLabel?.text = self.listaMunicipios[indexPath.row]
        return cell
    }
    
    var municipioSeleccionado = ""
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Se seleccionó el municipio \(listaMunicipios[indexPath.row])")
        municipioSeleccionado = listaMunicipios[indexPath.row]
        //self.performSegueWithIdentifier("PasemosACapturaDeDatosNumericos", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "PasemosACapturaDeDatosNumericos" {
        //    let controller = segue.destinationViewController as! MunicipiosViewControler
        //    controller.estadoSeleccionado = sender!.estadoSeleccionado
        //}
    }
}
