//
//  Kategorie+CoreDataProperties.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/22/25.
//
//

import Foundation
import CoreData


extension Kategorie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kategorie> {
        return NSFetchRequest<Kategorie>(entityName: "Kategorie")
    }

    @NSManaged public var color: String?
    @NSManaged public var generate_date: Date
    @NSManaged public var id: UUID
    @NSManaged public var is_hidden: Bool
    @NSManaged public var name: String
    @NSManaged public var revised_date: Date?
    @NSManaged public var sort_num: String
    @NSManaged public var works: NSSet?

    
    static func createNewKategorie(_ context: NSManagedObjectContext) -> Kategorie {
        let k = Kategorie(context: context)
        k.color = nil
        k.id = UUID()
        k.is_hidden = false
        k.name = ""
        k.generate_date = Date()
        k.sort_num = ""
        k.revised_date = nil
        k.works = nil
        return k
    }
    
    func canInsert() -> Bool {
        return !(name).isEmpty && !(sort_num).isEmpty
    }
}

// MARK: Generated accessors for works
extension Kategorie {

    @objc(addWorksObject:)
    @NSManaged public func addToWorks(_ value: Work)

    @objc(removeWorksObject:)
    @NSManaged public func removeFromWorks(_ value: Work)

    @objc(addWorks:)
    @NSManaged public func addToWorks(_ values: NSSet)

    @objc(removeWorks:)
    @NSManaged public func removeFromWorks(_ values: NSSet)

}

extension Kategorie : Identifiable {

}
