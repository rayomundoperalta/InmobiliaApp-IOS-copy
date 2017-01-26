//
//  Propiedades+CoreDataProperties.swift
//  
//
//  Created by Raymundo Peralta on 1/25/17.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Propiedades {

    @NSManaged var childPosition: NSNumber?
    @NSManaged var claseInmueble: NSNumber?
    @NSManaged var cp: NSNumber?
    @NSManaged var delegacion: NSNumber?
    @NSManaged var direccion: String?
    @NSManaged var entidad: NSNumber?
    @NSManaged var groupPosition: NSNumber?
    @NSManaged var id: String?
    @NSManaged var latitud: NSNumber?
    @NSManaged var longitud: NSNumber?
    @NSManaged var photoFileName: String?
    @NSManaged var proximidadUrbana: NSNumber?
    @NSManaged var revisadoManualmente: NSNumber?
    @NSManaged var sensibilidad: NSNumber?
    @NSManaged var superConstruido: NSNumber?
    @NSManaged var superTerreno: NSNumber?
    @NSManaged var telefono: String?
    @NSManaged var tipologia: NSNumber?
    @NSManaged var valConcluido: NSNumber?
    @NSManaged var valConst: NSNumber?
    @NSManaged var valDesStn: NSNumber?
    @NSManaged var valEstimado: NSNumber?
    @NSManaged var vidaUtil: NSNumber?
    @NSManaged var nombreMunicipio: String?
    @NSManaged var nombreEntidad: String?
    @NSManaged var nombreProximidadUrbana: String?
    @NSManaged var nombreTipologia: String?
    @NSManaged var nombreClaseInmueble: String?

}
