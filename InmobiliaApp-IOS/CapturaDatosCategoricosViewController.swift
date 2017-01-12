//
//  CapturaDatosCategoricosViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/11/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit

class CapturaDatosCategoricosViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var proximidadUrbanaPicker: UIPickerView!
    var proximidadUrbanaPickerData: [String] = [String]()
    var tipoInmueblePickerData: [String] = [String]()
    var claseInmueblePickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.proximidadUrbanaPicker.delegate   = self
        self.proximidadUrbanaPicker.dataSource = self
        proximidadUrbanaPickerData = ["Céntrica (1)", "Intermedia (2)", "Periférica (3)", "De expansión (4)", "Rural (5)"]
        tipoInmueblePickerData = ["Terreno (1)", "Casa habitación (2)", "Casa Condominio (3)", "Departamento condominio (4)", "Casas multiples (5)", "Otros (6)"]
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
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(8.0, weight: UIFontWeightRegular)])
        label.attributedText = title
        label.textAlignment = .Center
        return label
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
