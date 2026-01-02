//
//  Work+CoreDataProperties.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/22/25.
//
//

import Foundation
import CoreData


extension Work {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Work> {
        return NSFetchRequest<Work>(entityName: "Work")
    }

    @NSManaged public var closing_date: Date?
    @NSManaged public var id: UUID
    @NSManaged public var is_completed: Bool
    @NSManaged public var is_star: Bool
    @NSManaged public var memo: String?
    @NSManaged public var name: String
    @NSManaged public var starting_date: Date?
    @NSManaged public var kategorie: Kategorie?
    @NSManaged public var repetition: Repetition?
    @NSManaged public var subworks: NSSet?
    @NSManaged public var created_date: Date

    static func createNew(_ context: NSManagedObjectContext) -> Work {
        let new = Work(context: context)
        new.closing_date = nil
        new.id = UUID()
        new.is_completed = false
        new.is_star = false
        new.name = "new work"
        new.starting_date = nil
        new.kategorie = nil
        new.repetition = nil
        new.subworks = nil
        new.created_date = Date()
        return new
    }
    
    func addSubwork(_ context: NSManagedObjectContext) -> Work {
        let new = Subwork.createNew(context, work: self, sortNum: String(self.subworks?.count ?? 0))
        self.addToSubworks(new)
        return self
    }
}

// MARK: Generated accessors for subworks
extension Work {

    @objc(addSubworksObject:)
    @NSManaged public func addToSubworks(_ value: Subwork)

    @objc(removeSubworksObject:)
    @NSManaged public func removeFromSubworks(_ value: Subwork)

    @objc(addSubworks:)
    @NSManaged public func addToSubworks(_ values: NSSet)

    @objc(removeSubworks:)
    @NSManaged public func removeFromSubworks(_ values: NSSet)

}

extension Work : Identifiable {

}
