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
import CoreData

class MapController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    @IBOutlet var tableview: UITableView!
    var mapView:MKMapView!
    
    var localizador:CLLocationManager?
    var count:Int = 0
    
    var propiedades: [Propiedades] = []
    
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
        self.tableview.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
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
        print("Map Controler tableView cellForRow")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MapTableViewCell
        // Aqui vamos a decidir que presentamos en el mapa
        // una vez que tenemos la cell que se va a mostrar, tenemos el mapa sobre el que hay que trabajar
        mapView = cell.mapView
        mapView.delegate = self
        
        // veamos cuantas propiedades hay en la base de datos
        var propiedades:[Propiedades]?
        let managedContext = CoreDataStack.sharedInstance.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Propiedades")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            propiedades = results as! [Propiedades]
            print("--> \(propiedades!.count) propiedades en el catalogo")
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        /* Lineas usadas para saber de que tamaño es un diez milesima de grado */
        let offset: Double = 0.0001
        let ubicacion0:CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
        let ubicacion1:CLLocation = CLLocation(latitude: offset, longitude: offset)
        let dist = ubicacion0.distanceFromLocation(ubicacion1)
        print("tamaño de offset \(dist) metros")
        /* ------------------------------------------------------------------- */
        
        let losPines = self.mapView.annotations
        self.mapView.removeAnnotations(losPines)
        if propiedades!.count > 0 {
            let center:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            self.mapView.setRegion(region, animated: true)
            
            for prop in propiedades! {
                print("\(prop.direccion!) - \(prop.latitud!), \(prop.longitud!) - \(prop.id!)")
                let ubicacion:CLLocation = CLLocation(latitude: prop.latitud as! Double, longitude: prop.longitud as! Double)
                self.colocarMapa(ubicacion, conPropiedad: prop)
            }
            
        } else {
            print("->> ponemos localizacion actual")
            self.localizador = CLLocationManager()
            self.localizador!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.localizador!.delegate = self
            let autorizado = CLLocationManager.authorizationStatus()
            if autorizado == CLAuthorizationStatus.NotDetermined {
                print("Autorizado")
                self.localizador!.requestWhenInUseAuthorization()
            }
            self.localizador!.startUpdatingLocation()
        }
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
        self.localizador!.stopUpdatingLocation()
    }
    
    func colocarMapa(ubicacion:CLLocation){
        print("colocarMapa")
        let laCoordenada = ubicacion.coordinate
        let region = MKCoordinateRegionMakeWithDistance(laCoordenada, 100, 100)    // 1 Km de radio
        self.mapView.setRegion(region, animated: true)
        let losPines = self.mapView.annotations
        self.mapView.removeAnnotations(losPines)
        //let elPin = ElPin(title: "Ud. Está aqui", subtitle: "¿qué propiedad quiere ver hoy?", coordinate: laCoordenada)
        let elPin:ElPin = ElPin()
        elPin.title = "Ud. Está aqui"
        elPin.subtitle = "¿qué propiedad quiere ver hoy?"
        elPin.coordinate = laCoordenada
        self.mapView.addAnnotation(elPin)
    }
    
    func colocarMapa(ubicacion:CLLocation, conPropiedad propiedad:Propiedades) {
        print("colocarMapa con propiedad id lat \(ubicacion.coordinate.latitude) - \(ubicacion.coordinate.longitude)")
        let laCoordenada = ubicacion.coordinate
        let region = MKCoordinateRegionMakeWithDistance(laCoordenada, 100, 100)    // 1 Km de radio
        self.mapView.setRegion(region, animated: true)
        let losPines = self.mapView.annotations
        print("cuantas anotations \(losPines.count)")
        //self.mapView.removeAnnotations(losPines)
        //let elPin = ElPin(title: propiedad.direccion!, subtitle: propiedad.telefono!, coordinate: laCoordenada)
        var elPin:ElPin = ElPin()
        elPin.title = propiedad.direccion!
        elPin.subtitle = propiedad.telefono!
        elPin.coordinate = laCoordenada
        elPin.propiedad = propiedad
        var annotationView:MKPinAnnotationView!
        annotationView = MKPinAnnotationView(annotation: elPin, reuseIdentifier: "pin")
        self.mapView.addAnnotation(annotationView.annotation!)
        let losPines1 = self.mapView.annotations
        print("cuantas anotations despues \(losPines1.count)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Map Delegate */
    
    private let reuseIdentifier = "pinPropiedad"
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        print("-> mapView viewForAnnotation")
    
        if annotation is ElPin {
            print("La annotation es un ElPin")
            
            let reuseId = "pin"

            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
            } else {
                pinView!.annotation = annotation
            }
            
            //pinView.animatesDrop = true
            //pinView.pinTintColor = UIColor.blackColor()
            
            if (annotation as! ElPin).propiedad != nil {
                print("-- La propiedad es diferente de nil")
                let annotationPayLoad: String = (annotation as! ElPin).propiedad!.id!
                print(annotationPayLoad)
                let photoFileName = (annotation as! ElPin).propiedad?.photoFileName
                print("Imagen para annotation \(photoFileName)")
                let imageButton = UIButton()
                imageButton.frame.size.width = 80
                imageButton.frame.size.height = 80
                imageButton.backgroundColor = UIColor.redColor()
                imageButton.setImage(UIImage(contentsOfFile: photoFileName!), forState: .Normal) // aaqui va la foto
                pinView!.leftCalloutAccessoryView = imageButton

                
                let detailButton = PropiedadDetailButton(type: UIButtonType.Custom) as PropiedadDetailButton
                detailButton.frame.size.width = 44
                detailButton.frame.size.height = 44
                detailButton.backgroundColor = UIColor.redColor()
                detailButton.setImage(UIImage(named: "info"), forState: .Normal)
                detailButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
                detailButton.propiedad = (annotation as! ElPin).propiedad!
        
                pinView!.rightCalloutAccessoryView = detailButton
            }
            print("regresamos el pinView")
            return pinView
        } else {
            return nil
        }
    }

    var propiedad:Propiedades?
    
    func buttonAction(sender: UIButton!) {
        print("Button in annotation tapped")
        propiedad = (sender as! PropiedadDetailButton).propiedad
        print("--> PropiedadDetailButton ---- \(self.propiedad!.id)")
        /* Pasamos el control al view controler que muestra el detalle de la propiedad */
        
        self.performSegueWithIdentifier("pasemosAlDetalle", sender: self)
        print("Salimos del boton")
    }

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("-> mapView didSelectAnnotationView")
        // do something
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("-----> Se ejecuta el segue \(segue.identifier!)")
        let destinationViewController = segue.destinationViewController as! PropertyDetailViewController
        destinationViewController.propiedad = self.propiedad
    }
}
