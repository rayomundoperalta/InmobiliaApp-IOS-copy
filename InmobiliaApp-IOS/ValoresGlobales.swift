//
//  ValoresGlobales.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 12/28/16.
//  Copyright © 2016 Industrias Peta. All rights reserved.
//

import Foundation

class ValoresGlobales {
    
    static let sharedInstance = ValoresGlobales()
    
    var userName:  String = ""
    var userEmail: String = ""
    
    private init() { }
}