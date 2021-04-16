

import Foundation
import CoreData


extension School {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<School> {
        return NSFetchRequest<School>(entityName: "School")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

