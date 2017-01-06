//
//  ElPin.swift
//  GPSTest
//
//  Created by Raymundo Peralta on 10/22/16.
//  Copyright © 2016 Raymundo Peralta. All rights reserved.
//

import Foundation
import MapKit

class ElPin:NSObject, MKAnnotation {
    var title:String?
    var subtitle:String?
    let coordinate:CLLocationCoordinate2D
    
    init(title: String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
