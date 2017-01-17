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
    
    var estadoSeleccionado: String = ""
    var claveDeMunicipioSeleccionado: String = ""
    var municipioSeleccionado: String = ""
    
    var CP: String = ""
    var vidaUtil: String = ""
    var superficieTerreno: String = ""
    var superficieConstruida: String = ""
    var valorConstrucción: String = ""
    var precio: String = ""
    var dirección: String = ""
    var teléfono: String = ""
    
    var proximidadUrbana: Double = 0.0
    var tipoInmuebles: Double = 0.0
    var claseInmueble: Double = 0.0
    
    var photoPath: String = ""
    
    var latitud: Double = 0.0
    var longitud: Double = 0.0
    
    var verificadoManualmente: Int = 0
    var sensibilidad: Double = 0.0
    
    private init() { }
}