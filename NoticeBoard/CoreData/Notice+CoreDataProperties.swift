

import Foundation
import CoreData


extension Notice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notice> {
        return NSFetchRequest<Notice>(entityName: "Notice")
    }

    @NSManaged public var imagedata: Data?
    @NSManaged public var title: String?
    @NSManaged public var notice: String?
    @NSManaged public var teacher: String?
    @NSManaged public var date: String?

}
