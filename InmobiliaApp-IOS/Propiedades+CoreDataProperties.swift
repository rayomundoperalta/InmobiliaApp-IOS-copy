//
//  Propiedades+CoreDataProperties.swift
//  
//
//  Created by Raymundo Peralta on 1/13/17.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Propiedades {

    @NSManaged var telefono: String?
    @NSManaged var direccion: String?
    @NSManaged var latitud: NSNumber?
    @NSManaged var longitud: NSNumber?
    @NSManaged var photoFileName: String?
    @NSManaged var tipologia: NSNumber?
    @NSManaged var cp: NSNumber?
    @NSManaged var delegacion: NSNumber?
    @NSManaged var entidad: NSNumber?
    @NSManaged var proximidadUrbana: NSNumber?
    @NSManaged var claseInmueble: NSNumber?
    @NSManaged var vidaUtil: NSNumber?
    @NSManaged var superTerreno: NSNumber?
    @NSManaged var superConstruido: NSNumber?
    @NSManaged var valConst: NSNumber?
    @NSManaged var valConcluido: NSNumber?
    @NSManaged var valEstimado: NSNumber?
    @NSManaged var valDesStn: NSNumber?
    @NSManaged var revisadoManualmente: NSNumber?
    @NSManaged var sensibilidad: NSNumber?
    @NSManaged var groupPosition: NSNumber?
    @NSManaged var childPosition: NSNumber?

}
