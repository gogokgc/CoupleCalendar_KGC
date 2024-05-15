//
//  RelationshipModel.swift
//  CoupleCalendar_KGC
//
//  Created by KYUCHEOL KIM on 5/15/24.
//

import Foundation
import CoreData

public class Relationship: NSManagedObject, Identifiable {
    @NSManaged public var startDate: Date
    @NSManaged public var memos: NSSet?
}

extension Relationship {
    static func getAllRelationships() -> NSFetchRequest<Relationship> {
        let request: NSFetchRequest<Relationship> = Relationship.fetchRequest() as! NSFetchRequest<Relationship>
        request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        return request
    }
}
