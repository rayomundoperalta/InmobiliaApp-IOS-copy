//
//  MapController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 1/5/17.
//  Copyright © 2017 Industrias Peta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapController: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var mapView:MKMapView!
    
    var localizador:CLLocationManager?
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-----> Map Controller viewDidLoad <-----")
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        print(">>>>> MapController wil appear <<<<<")
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.localizador!.stopUpdatingLocation()
        print(">>>>> MapController will disappear <<<<<<")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        print("Number of sections")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        print("Number of rows")
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("tableView cellForRow")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MapTableViewCell
        
        mapView = cell.mapView
        
        self.localizador = CLLocationManager()
        self.localizador!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.localizador!.delegate = self
        let autorizado = CLLocationManager.authorizationStatus()
        if autorizado == CLAuthorizationStatus.NotDetermined {
            print("Autorizado")
            self.localizador!.requestWhenInUseAuthorization()
        }
        self.localizador!.startUpdatingLocation()
        
        return cell
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("locationManager fail")
        self.localizador!.stopUpdatingLocation()
        let ac = UIAlertController(title: "Error", message: "No se pueden obtener lecturas GPS", preferredStyle: .Alert)
        let ab = UIAlertAction (title: "no podemos continuar", style: .Default, handler: nil)
        ac.addAction(ab)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager didUpdateLocations")
        let ubicacion = locations.last
        self.count += 1
        print ("self.count \(self.count)")
        print("Lat: " + "\(ubicacion!.coordinate.latitude)")
        print("Lon: " + "\(ubicacion!.coordinate.longitude)")
        self.colocarMapa(ubicacion!)
    }
    
    func colocarMapa(ubicacion:CLLocation){
        print("colocarMapa")
        let laCoordenada = ubicacion.coordinate
        let region = MKCoordinateRegionMakeWithDistance(laCoordenada, 100, 100)    // 1 Km de radio
        self.mapView.setRegion(region, animated: true)
        let losPines = self.mapView.annotations
        self.mapView.removeAnnotations(losPines)
        let elPin = ElPin(title: "Ud. Está aqui", subtitle: "", coordinate: laCoordenada)
        self.mapView.addAnnotation(elPin)
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
