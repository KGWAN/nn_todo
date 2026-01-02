//
//  Subwork+CoreDataProperties.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/22/25.
//
//

import Foundation
import CoreData


extension Subwork {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subwork> {
        return NSFetchRequest<Subwork>(entityName: "Subwork")
    }

    @NSManaged public var id: UUID
    @NSManaged public var is_completed: Bool
    @NSManaged public var name: String
    @NSManaged public var sort_num: String
    @NSManaged public var work: Work

    
    static func createNew(_ context: NSManagedObjectContext, work: Work, sortNum: String) -> Subwork {
        let new = Subwork(context: context)
        new.id = UUID()
        new.is_completed = false
        new.name = "new work"
        new.sort_num = sortNum
        new.work = work
        return new
    }
}

extension Subwork : Identifiable {

}
