

import Foundation
import CoreData


extension Parent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Parent> {
        return NSFetchRequest<Parent>(entityName: "Parent")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}
