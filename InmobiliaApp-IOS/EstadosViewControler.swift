//
//  EstadosViewControler.swift
//  CaEdMu
//
//  Created by Raymundo Peralta on 12/27/16.
//  Copyright © 2016 Industrias Peta. All rights reserved.
//

import UIKit

class EstadosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let estados = CatalogoEstadosMunicipios.sharedInstance.catalogoEdosMun.keys.sort(<)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.estados.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.estados[indexPath.row]
        return cell
    }
    
    var estadoSeleccionado : String = ""
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Se seleccionó \(estados[indexPath.row])")
        estadoSeleccionado = estados[indexPath.row]
        self.performSegueWithIdentifier("PasemosASelecciónDeMunicipios", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PasemosASelecciónDeMunicipios" {
            let controller = segue.destinationViewController as! MunicipiosViewControler
            controller.estadoSeleccionado = sender!.estadoSeleccionado
        }
    }
}

