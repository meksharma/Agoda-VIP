import SwiftUI

enum AppRoute: Hashable { case home, vipStatus, search, results, property, rooms, roomInfo, booking, upgrade, confirmation }

enum VIPTier: String, Hashable {
    case gold = "Gold"
    case platinum = "Platinum"

    var accent: Color { self == .gold ? AgodaColor.gold : AgodaColor.platinum }
    var discount: String { self == .gold ? "18%" : "25%" }
    var agodaCash: String { self == .gold ? "1x" : "1.5x" }
    var searchSavings: String { self == .gold ? "฿555" : "฿675" }
    var roomPrice: String { self == .gold ? "฿ 13,924" : "฿ 3,481" }
    var discountLabel: String { self == .gold ? "-20% TODAY" : "-75% TODAY" }
}

enum AgodaColor {
    static let ink = Color(red: 42 / 255, green: 42 / 255, blue: 46 / 255)
    static let secondary = Color(red: 112 / 255, green: 112 / 255, blue: 112 / 255)
    static let line = Color(red: 213 / 255, green: 217 / 255, blue: 226 / 255)
    static let soft = Color(red: 250 / 255, green: 250 / 255, blue: 251 / 255)
    static let blue = Color(red: 62 / 255, green: 108 / 255, blue: 234 / 255)
    static let gold = Color(red: 250 / 255, green: 215 / 255, blue: 62 / 255)
    static let platinum = Color(red: 85 / 255, green: 104 / 255, blue: 188 / 255)
    static let green = Color(red: 40 / 255, green: 135 / 255, blue: 28 / 255)
    static let red = Color(red: 225 / 255, green: 45 / 255, blue: 45 / 255)
    static let orange = Color(red: 229 / 255, green: 89 / 255, blue: 0)
    static let darkVIP = Color(red: 42 / 255, green: 42 / 255, blue: 58 / 255)
}

struct Hotel: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let location: String
    let rating: String
    let price: String

    static let results = [
        Hotel(name: "Paloma Eco Friendly Luxury Pool", image: "SearchHotel1", location: "Chaweng", rating: "9.1 Excellent", price: "฿ 3,481"),
        Hotel(name: "Pandora Luxury Pool", image: "SearchHotel2", location: "Chaweng", rating: "8.9 Excellent", price: "฿ 1,600"),
        Hotel(name: "Four Seasons Resort Koh Samui, Thailand", image: "SearchHotel3", location: "Koh Samui", rating: "9.1 Exceptional", price: "฿ 4,200"),
        Hotel(name: "Casa De Mar Hotel", image: "SearchHotel4", location: "SHA Plus+", rating: "8.4 Excellent", price: "฿ 1,720"),
        Hotel(name: "SALA Samui Choengmon Beach", image: "SearchHotel5", location: "Choengmon", rating: "8.8 Excellent", price: "฿ 1,895"),
        Hotel(name: "Le Mottu", image: "SearchHotel6", location: "Bo Phut", rating: "8.1 Excellent", price: "฿ 931")
    ]
}