

import Foundation
import UIKit

struct R {
    struct Color {
        static var primary_color = "Primary"
        static var black_color = "Black"
        static var white_color = "White"
        static var gray_color = "Gray"
        static var light_gray = "PlaceHolder"
        static var offer_red = "Offer"
        static var unread_notify = "UnreadNotify"
    }}




extension Notification.Name {
    static let NotifyCount = Notification.Name("NotifyCount")
}
