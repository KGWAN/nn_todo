//
//  Repetition+CoreDataProperties.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/22/25.
//
//

import Foundation
import CoreData


extension Repetition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repetition> {
        return NSFetchRequest<Repetition>(entityName: "Repetition")
    }

    @NSManaged public var closing_date: Date?
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var starting_date: String?
    @NSManaged public var works: NSSet?

}

// MARK: Generated accessors for works
extension Repetition {

    @objc(addWorksObject:)
    @NSManaged public func addToWorks(_ value: Work)

    @objc(removeWorksObject:)
    @NSManaged public func removeFromWorks(_ value: Work)

    @objc(addWorks:)
    @NSManaged public func addToWorks(_ values: NSSet)

    @objc(removeWorks:)
    @NSManaged public func removeFromWorks(_ values: NSSet)

}

extension Repetition : Identifiable {

}
