//
//  EstimacionesCompradas+CoreDataProperties.swift
//  
//
//  Created by Raymundo Peralta on 1/19/17.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension EstimacionesCompradas {

    @NSManaged var id: String?
    @NSManaged var fechaCompra: String?
    @NSManaged var payKey: String?

}
