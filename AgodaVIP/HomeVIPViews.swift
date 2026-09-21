import SwiftUI

struct HomeView: View {
    let tier: VIPTier
    let onVIP: () -> Void
    let onHotel: () -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                HStack {
                    HStack(spacing: 0) { ForEach(Array("agoda".enumerated()), id: \.offset) { index, letter in Text(String(letter)).foregroundStyle([Color.red, .orange, .green, .blue, .purple][index]) } }.font(.system(size: 22, weight: .bold))
                    Spacer(); Image(systemName: "person.crop.circle"); Image(systemName: "wallet.pass").padding(.leading, 14)
                }.padding(.horizontal, 14).frame(height: 48)
                categories
                vipPanel
                SectionTitle(title: "Promotions")
                ScrollView(.horizontal) { HStack(spacing: 10) { HotelPhoto(image: "HomePromo", height: 100).frame(width: 190); HotelPhoto(image: "HomeHero", height: 100).frame(width: 190) }.padding(.horizontal, 12) }.scrollIndicators(.hidden)
                bookingCard
                carousel("Upcoming trip", ["SearchHotel1", "SearchHotel2"])
                carousel("Recent viewed", ["RoomExecutive", "RoomLuxury"])
                carousel("See today's deals", ["SearchHotel4", "SearchHotel5"])
                cashback
                carousel("Discover hotels in top destinations", ["HomeDestination", "HomeHero"])
                carousel("Explore all Agoda Homes", ["HomeApartment", "RoomSuperior"])
                Button(action: onHotel) { Text("Featured Agoda Homes").font(.system(size: 17, weight: .medium)).frame(maxWidth: .infinity, alignment: .leading).padding(12) }.buttonStyle(.plain).foregroundStyle(AgodaColor.ink)
                Color.clear.frame(height: 70)
            }
        }.scrollIndicators(.hidden).background(Color.white).safeAreaInset(edge: .bottom, spacing: 0) { HomeTabBar() }
    }

    private var categories: some View {
        ScrollView(.horizontal) { HStack(spacing: 10) { category("All rooms", "HomeApartment", .red.opacity(0.15)); category("Flights", "HomeHero", AgodaColor.gold.opacity(0.25)); category("Flight + room", "HomeDestination", .green.opacity(0.2)); category("Things to do", "HomePromo", .purple.opacity(0.16)) }.padding(.horizontal, 12) }.scrollIndicators(.hidden)
    }

    private func category(_ title: String, _ image: String, _ tint: Color) -> some View {
        ZStack(alignment: .topLeading) { tint; Image(image).resizable().scaledToFill().opacity(0.75); Text(title).font(.system(size: 12)).padding(8) }.frame(width: 105, height: 82).clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private var vipPanel: some View {
        Button(action: onVIP) {
            HStack { VStack(alignment: .leading, spacing: 5) { Text("VIP status").font(.system(size: 13)); Text(tier == .gold ? "You're getting up to 18% booking discount" : "Congratulations! Platinum gives up to 25% off").font(.system(size: 11)).foregroundStyle(AgodaColor.secondary).multilineTextAlignment(.leading) }; Spacer(); VIPBadge(tier: tier) }
                .padding(12).background(Color.white, in: RoundedRectangle(cornerRadius: 10)).overlay { RoundedRectangle(cornerRadius: 10).stroke(AgodaColor.line) }
        }.buttonStyle(.plain).padding(12)
    }

    private var bookingCard: some View {
        VStack(spacing: 0) { SectionTitle(title: "Back to your booking"); HStack(spacing: 10) { Image("BookingHotel").resizable().scaledToFill().frame(width: 56, height: 42).clipped().clipShape(RoundedRectangle(cornerRadius: 5)); VStack(alignment: .leading) { Text("SALA Samui Choengmon Beach").font(.system(size: 13, weight: .medium)); Text("Sep 30 – Oct 1 · 1 room 2 adults").font(.system(size: 11)).foregroundStyle(AgodaColor.secondary) }; Spacer(); Image(systemName: "chevron.right") }.padding(.horizontal, 12) }
    }

    private func carousel(_ title: String, _ images: [String]) -> some View {
        VStack(spacing: 0) { SectionTitle(title: title, action: "See all"); ScrollView(.horizontal) { HStack(spacing: 10) { ForEach(images, id: \.self) { image in VStack(alignment: .leading, spacing: 4) { HotelPhoto(image: image, height: 112).frame(width: 180); Text("Paloma Eco Friendly Luxury Pool").font(.system(size: 12, weight: .medium)).lineLimit(2); Text("9.1 Excellent").font(.system(size: 11)).foregroundStyle(AgodaColor.blue) } }.padding(.horizontal, 12) }.padding(.bottom, 4) }.scrollIndicators(.hidden) }
    }

    private var cashback: some View {
        VStack(spacing: 0) { SectionTitle(title: "Agoda Cash"); HStack { Image(systemName: "a.circle.fill").foregroundStyle(AgodaColor.platinum); VStack(alignment: .leading) { Text("AgodaCash balance").font(.system(size: 12)).foregroundStyle(AgodaColor.platinum); Text("฿ 238.46").font(.system(size: 12)) }; Spacer(); Image(systemName: "chevron.right") }.padding(12).overlay { RoundedRectangle(cornerRadius: 8).stroke(AgodaColor.line) }.padding(.horizontal, 12) }
    }
}

struct VIPStatusView: View {
    let tier: VIPTier
    let onBack: () -> Void
    let onSearch: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            AgodaNavBar(title: "AgodaVIP", onBack: onBack)
            ScrollView { VStack(spacing: 0) { vipCard; statusMessage; benefits; faq; destinations } }.scrollIndicators(.hidden)
        }
        .safeAreaInset(edge: .bottom) { PrimaryButton(title: "Start searching", action: onSearch).padding(.horizontal, 16).padding(.vertical, 8).background(Color.white) }
    }

    private var vipCard: some View {
        VStack(alignment: .leading, spacing: 22) { Text("★ VIP \(tier.rawValue)").font(.system(size: 16, weight: .bold)).foregroundStyle(.white); Text("Expires on Apr 21, 2021").font(.system(size: 11)).foregroundStyle(.white.opacity(0.7)); VStack(alignment: .leading, spacing: 2) { Text("Your bookings in last 2 years").font(.system(size: 11)).foregroundStyle(.white.opacity(0.7)); Text(tier == .gold ? "8 bookings" : "10 bookings").font(.system(size: 13, weight: .bold)).foregroundStyle(.white) } }
            .padding(16).frame(maxWidth: .infinity, alignment: .leading).background(LinearGradient(colors: [AgodaColor.darkVIP, AgodaColor.darkVIP, tier.accent], startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 12)).padding(12)
    }

    private var statusMessage: some View { Text(tier == .platinum ? "🎉 Congratulations! You just got upgraded to VIP Platinum!" : "You are 2 bookings away from VIP Platinum!").font(.system(size: 13, weight: .semibold)).foregroundStyle(tier == .platinum ? AgodaColor.platinum : AgodaColor.ink).padding(12).frame(maxWidth: .infinity, alignment: .leading) }

    private var benefits: some View {
        VStack(alignment: .leading, spacing: 16) { HStack { Text("Hi Mehak! Your current benefits").font(.system(size: 18)); Spacer(); VIPBadge(tier: tier) }; BulletRow(symbol: "tag.fill", text: "Get up to \(tier.discount) VIP discount", color: tier.accent); BulletRow(symbol: "dollarsign.circle.fill", text: "Earn \(tier.agodaCash) more AgodaCash", color: tier.accent); BulletRow(symbol: "person.crop.circle.badge.checkmark", text: "Best price guarantee", color: tier.accent); BulletRow(symbol: "gift.fill", text: "Insider deals", color: tier.accent) }.padding(14).overlay(alignment: .top) { AgodaColor.line.frame(height: 0.5) }
    }

    private var faq: some View {
        VStack(spacing: 8) { SectionTitle(title: "Frequently asked questions"); ForEach(["What is the AgodaVIP program?", "How are VIP Bookings counted?", "Which bookings are eligible?", "Can my AgodaVIP be downgraded?"], id: \.self) { text in HStack { Text(text).font(.system(size: 13)); Spacer(); Image(systemName: "chevron.right") }.padding(14).overlay { RoundedRectangle(cornerRadius: 10).stroke(AgodaColor.line) }.padding(.horizontal, 12) }; Text("Term and Conditions").font(.system(size: 11)).foregroundStyle(AgodaColor.blue).frame(maxWidth: .infinity, alignment: .leading).padding(12) }
    }

    private var destinations: some View {
        VStack(spacing: 0) { SectionTitle(title: "Discover AgodaVIP hotels in top destinations"); HStack(spacing: 10) { destination("HomeDestination", "Hua Hin / Cha-am"); destination("HomeHero", "Phuket") }.padding(.horizontal, 12) }
    }

    private func destination(_ image: String, _ title: String) -> some View { VStack(alignment: .leading, spacing: 4) { HotelPhoto(image: image, height: 130); Text(title).font(.system(size: 12, weight: .medium)); Text("123 km away\nRomance | Beaches\n฿ 2,300 average price per night").font(.system(size: 10)).foregroundStyle(AgodaColor.secondary) } }
}

private struct HomeTabBar: View {
    var body: some View { HStack { tab("house.fill", "Home", true); tab("heart", "Saved", false); tab("suitcase", "Bookings", false); tab("message", "Coupons", false); tab("ellipsis", "More", false) }.frame(height: 58).background(Color.white).overlay(alignment: .top) { AgodaColor.line.frame(height: 0.5) } }
    private func tab(_ symbol: String, _ label: String, _ selected: Bool) -> some View { VStack(spacing: 2) { Image(systemName: symbol); Text(label).font(.system(size: 9)) }.foregroundStyle(selected ? AgodaColor.blue : AgodaColor.secondary).frame(maxWidth: .infinity) }
}