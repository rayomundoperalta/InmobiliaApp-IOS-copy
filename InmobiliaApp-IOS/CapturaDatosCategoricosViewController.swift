//
//  CapturaDatosCategoricosViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/11/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit
import MapKit

extension Int {
    func format(formato: String) -> String {
        return String(format: "%\(formato)d", self)
    }
}

extension Double {
    func format(formato: String) -> String {
        return String(format: "%\(formato)f", self)
    }
}

class CapturaDatosCategoricosViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var proximidadUrbanaPicker: UIPickerView!
    var proximidadUrbanaPickerData: [String] = [String]()
    var tipoInmueblePickerData: [String] = [String]()
    var claseInmueblePickerData: [String] = [String]()
    
    var imagePicker: UIImagePickerController!
    
    var localizador:CLLocationManager?
    
    @IBOutlet weak var fotoPropiedad: UIImageView!
    @IBAction func tomarFoto(sender: UIButton) {
        self.localizador = CLLocationManager()
        self.localizador!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.localizador!.delegate = self
        let autorizado = CLLocationManager.authorizationStatus()
        if autorizado == CLAuthorizationStatus.NotDetermined {
            print("Autorizado")
            self.localizador!.requestWhenInUseAuthorization()
        }
        self.localizador!.startUpdatingLocation()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var reporteValorEstimado: UILabel!
    @IBOutlet weak var latitud: UILabel!
    @IBOutlet weak var longuitud: UILabel!
    @IBAction func estimarValor(sender: UIButton) {
    }
    @IBAction func guardar(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.proximidadUrbanaPicker.delegate   = self
        self.proximidadUrbanaPicker.dataSource = self
        proximidadUrbanaPickerData = ["Céntrica (1)", "Intermedia (2)", "Periférica (3)", "De expansión (4)", "Rural (5)"]
        tipoInmueblePickerData = ["Terreno (1)", "Casa habitación (2)", "Casa Condominio (3)", "Depto condominio (4)", "Casas multiples (5)", "Otros (6)"]
        claseInmueblePickerData = ["Mínima (1)", "Económica (2)", "Interés Social (3)", "Medio (4)", "Semilujo (5)", "Residencial (6)", "Residencial plus (7)"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (component) {
        case 0:
            return proximidadUrbanaPickerData.count
        case 1:
            return tipoInmueblePickerData.count
        case 2:
            return claseInmueblePickerData.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (component) {
        case 0:
            return proximidadUrbanaPickerData[row]
        case 1:
            return tipoInmueblePickerData[row]
        case 2:
            return claseInmueblePickerData[row]
        default:
            break
        }
        return "error"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selección en el pickerView \(component)-\(row)")
        switch (component) {
        case 0:
            print(proximidadUrbanaPickerData[row])
            break
        case 1:
            print(tipoInmueblePickerData[row])
            break
        case 2:
            print(claseInmueblePickerData[row])
            break
        default:
            print("error")
            break
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        var data: String = ""
        switch (component) {
        case 0:
            data = proximidadUrbanaPickerData[row]
            break
        case 1:
            data = tipoInmueblePickerData[row]
            break
        case 2:
            data = claseInmueblePickerData[row]
            break
        default:
            data = "error"
            break
        }
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)])
        label.attributedText = title
        label.textAlignment = .Center
        return label
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        fotoPropiedad.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        print("Image size \(fotoPropiedad.image!.size)")
        
        let filename = "foto1.jpg"
        let subfolder = "Propiedades"
        
        do {
            let fileManager = NSFileManager.defaultManager()
            let documentsURL = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
            print("1->\(documentsURL.absoluteString)")
            let folderURL = documentsURL.URLByAppendingPathComponent(subfolder)
            if !folderURL.checkPromisedItemIsReachableAndReturnError(nil) {
                try fileManager.createDirectoryAtURL(folderURL, withIntermediateDirectories: true, attributes: nil)
            }
            
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
            //let destinationPath = documentDirectoryPath.URLByAppendingPathComponent("contacts1.db")
            let fotoPath = documentDirectoryPath + "/Propiedades/" + filename
            print("Paths: \(fotoPath)")
            UIImageJPEGRepresentation(fotoPropiedad.image!, 1.0)!.writeToFile(fotoPath, atomically: true)
            // Retrieve image from file
            
            let newImage = UIImage(contentsOfFile: fotoPath)!
            
            print("Image size = \(newImage.size)")
            fotoPropiedad.image = newImage
        } catch {
            print(error)
        }
        self.localizador!.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("locationManager fail")
        self.localizador!.stopUpdatingLocation()
        let ac = UIAlertController(title: "Error", message: "No se pueden obtener lecturas GPS", preferredStyle: .Alert)
        let ab = UIAlertAction (title: "no podemos continuar", style: .Default, handler: nil)
        ac.addAction(ab)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    var count: Int = 0
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("locationManager didUpdateLocations")
        let ubicacion = locations.last
        self.count += 1
        print ("self.count \(self.count)")
        print("Lat: " + "\(ubicacion!.coordinate.latitude)")
        print("Lon: " + "\(ubicacion!.coordinate.longitude)")
        latitud.font = UIFont(name: "Times New Roman", size: 18.0)
        latitud.text = "Lat: " + "\(ubicacion!.coordinate.latitude.format(".8"))"
        longuitud.font = UIFont(name: "Times New Roman", size: 18.0)
        longuitud.text = "Lon: " + "\(ubicacion!.coordinate.longitude.format(".8"))"
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