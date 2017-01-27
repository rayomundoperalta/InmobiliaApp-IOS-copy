//
//  EstimacionesCompradas+CoreDataProperties.swift
//  
//
//  Created by Raymundo Peralta on 1/26/17.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension EstimacionesCompradas {

    @NSManaged var fechaCompra: String?
    @NSManaged var id: String?
    @NSManaged var payKey: String?
    @NSManaged var currencyCode: String?
    @NSManaged var amount: String?
    @NSManaged var descripcion: String?
    @NSManaged var intent: String?
    @NSManaged var processable: String?
    @NSManaged var display: String?
    @NSManaged var state: String?
    
}
