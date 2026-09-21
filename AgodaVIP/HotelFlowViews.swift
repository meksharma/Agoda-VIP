import SwiftUI

struct HotelSearchView: View {
    let tier: VIPTier
    let onBack: () -> Void
    let onSearch: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                LinearGradient(colors: [Color(red: 1, green: 0.82, blue: 0.84), Color(red: 1, green: 0.91, blue: 0.92)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: 130)
                VStack(alignment: .leading, spacing: 12) {
                    Button(action: onBack) { Image(systemName: "chevron.left").frame(width: 38, height: 38).background(.white, in: Circle()).shadow(radius: 3) }.buttonStyle(.plain)
                    Text("All rooms").font(.system(size: 30, weight: .medium))
                }.padding(.horizontal, 16).padding(.top, 10)
            }

            CardContainer {
                VStack(spacing: 0) {
                    field("magnifyingglass", "Koh Samui (Near me)")
                    Divider()
                    HStack { field("calendar", "Tue, Sep 4"); Divider().frame(height: 44); field("calendar", "Sat, Sep 8") }
                    Divider()
                    field("person.fill", "1 room 2 adults")
                    Divider()
                    HStack(spacing: 12) {
                        Image(systemName: "map.fill").foregroundStyle(AgodaColor.blue).frame(width: 44, height: 44).overlay { Circle().stroke(AgodaColor.blue) }
                        PrimaryButton(title: "Search", action: onSearch)
                    }.padding(.top, 10)
                }
            }.padding(.horizontal, 16).offset(y: -34)

            HStack {
                VStack(alignment: .leading) { Text("Your total AgodaVIP savings").font(.system(size: 12)); Text(tier.searchSavings).font(.system(size: 20, weight: .medium)) }
                Spacer(); VIPBadge(tier: tier)
            }
            .padding(12).overlay { RoundedRectangle(cornerRadius: 12).stroke(AgodaColor.line) }.padding(.horizontal, 16).offset(y: -24)
            Spacer()
        }.foregroundStyle(AgodaColor.ink).background(Color.white)
    }

    private func field(_ symbol: String, _ title: String) -> some View {
        HStack(spacing: 8) { Image(systemName: symbol).font(.system(size: 17)); Text(title).font(.system(size: 15)); Spacer() }.frame(maxWidth: .infinity).frame(height: 52)
    }
}

struct HotelResultsView: View {
    let tier: VIPTier
    let onBack: () -> Void
    let onHotel: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            AgodaNavBar(title: "Koh Samui", onBack: onBack)
            HStack { filter("Price"); filter("Best Match"); filter("Filters"); filter("Homes") }.padding(.horizontal, 8).padding(.vertical, 8)
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(Hotel.results) { hotel in
                        Button(action: onHotel) { HotelResultCard(hotel: hotel, tier: tier) }.buttonStyle(.plain)
                    }
                }.padding(.horizontal, 8).padding(.bottom, 24)
            }.scrollIndicators(.hidden)
        }.background(AgodaColor.soft)
    }

    private func filter(_ text: String) -> some View { Text(text).font(.system(size: 10)).frame(maxWidth: .infinity).padding(.vertical, 7).overlay { Capsule().stroke(AgodaColor.line) } }
}

private struct HotelResultCard: View {
    let hotel: Hotel
    let tier: VIPTier
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topTrailing) { HotelPhoto(image: hotel.image, height: 132); Image(systemName: "heart").padding(9).background(.white.opacity(0.9), in: Circle()).padding(7) }
            Text(hotel.name).font(.system(size: 15, weight: .medium)).lineLimit(2)
            HStack(spacing: 3) { Text("★★★★★").foregroundStyle(AgodaColor.orange); Text(hotel.location).foregroundStyle(AgodaColor.secondary) }.font(.system(size: 10))
            Text(hotel.rating).font(.system(size: 11, weight: .medium)).foregroundStyle(AgodaColor.blue)
            HStack { VIPBadge(tier: tier); Spacer(); VStack(alignment: .trailing) { Text(tier.discountLabel).font(.system(size: 10)).foregroundStyle(AgodaColor.red); Text(tier == .gold ? hotel.price : "฿ 3,481").font(.system(size: 18, weight: .bold)).foregroundStyle(AgodaColor.red); Text("1 night with taxes").font(.system(size: 9)).foregroundStyle(AgodaColor.secondary) } }
            HStack { Text("Breakfast included"); Spacer(); Text("Free cancellation") }.font(.system(size: 10)).foregroundStyle(AgodaColor.green)
        }.padding(8).background(Color.white, in: RoundedRectangle(cornerRadius: 10)).overlay { RoundedRectangle(cornerRadius: 10).stroke(AgodaColor.line) }
    }
}

struct PropertyView: View {
    let tier: VIPTier
    let onBack: () -> Void
    let onRooms: () -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                hero
                overview
                SectionTitle(title: "Reviews")
                reviews
                SectionTitle(title: "Highlights", action: "Learn more")
                VStack(spacing: 10) { BulletRow(symbol: "mappin.circle.fill", text: "Great location"); BulletRow(symbol: "hand.thumbsup.fill", text: "Excellent reviews"); BulletRow(symbol: "leaf.fill", text: "Clean and hygienic plus") }.padding(.horizontal, 12)
                SectionTitle(title: "Location", action: "See map")
                HotelPhoto(image: "PropertyMap", height: 185).padding(.horizontal, 12)
                chips
                horizontalOffers
                detailSection("Hotel policies", ["Children and Extra beds", "Extra bed available", "Stay for free if using existing bedding."])
                detailSection("Languages spoken", ["🇺🇸 English", "🇹🇭 Thai"])
                detailSection("Some helpful facts", ["Check-in from: 15:00", "Check-out until: 11:59", "Airport transfer fee: 500 THB", "Travel time to airport: 35 minutes"])
                detailSection("Nearest essentials", ["Don Muang Int. Airport | 5.6 km", "Public transportation | 100 m", "Hospital or clinic | 500 m"])
                detailSection("Hotel description", ["Well-placed in the beaches area, family fun area of Phuket city. This hotel offers easy access to top city attractions."])
                Color.clear.frame(height: 88)
            }
        }.scrollIndicators(.hidden).background(Color.white).safeAreaInset(edge: .bottom) { bottomBar }
    }

    private var hero: some View {
        ZStack(alignment: .top) {
            HotelPhoto(image: "PropertyHero", height: 230).clipShape(Rectangle())
            HStack { Button(action: onBack) { Image(systemName: "chevron.left") }; Spacer(); Image(systemName: "heart"); Image(systemName: "square.and.arrow.up").padding(.leading, 12) }.font(.system(size: 18, weight: .semibold)).foregroundStyle(.white).padding(16)
        }
    }

    private var overview: some View {
        VStack(alignment: .leading, spacing: 5) { Text("Paloma Eco Friendly Luxury Pool").font(.system(size: 17, weight: .medium)); Text("★★★★★  9.1 Excellent").font(.system(size: 11)).foregroundStyle(AgodaColor.blue); HStack { VIPBadge(tier: tier); Text("Agoda EasyCancel").font(.system(size: 10)).padding(4).overlay { RoundedRectangle(cornerRadius: 3).stroke(AgodaColor.line) } } }.padding(12).frame(maxWidth: .infinity, alignment: .leading)
    }

    private var reviews: some View { ScrollView(.horizontal) { HStack { review("Brand new hotel that comes with everything you would..."); review("Brand new with everything") }.padding(.horizontal, 12) }.scrollIndicators(.hidden) }
    private func review(_ text: String) -> some View { VStack(alignment: .leading) { Text("\"\(text)\"").font(.system(size: 11)); Text("🇩🇰 Darren | Malaysia").font(.system(size: 9)).foregroundStyle(AgodaColor.secondary) }.padding(10).frame(width: 175, alignment: .leading).overlay { RoundedRectangle(cornerRadius: 8).stroke(AgodaColor.line) } }

    private var chips: some View { ScrollView(.horizontal) { HStack { Text("Near public transit"); Text("Near airport"); Text("Near market") }.font(.system(size: 10)).padding(.horizontal, 12) }.scrollIndicators(.hidden) }

    private var horizontalOffers: some View {
        VStack(spacing: 0) { SectionTitle(title: "What they offer", action: "See all"); HStack(spacing: 10) { offer("PropertyPet", "Pet friendly"); offer("PropertyParking", "Free parking") }.padding(.horizontal, 12) }
    }
    private func offer(_ image: String, _ title: String) -> some View { VStack(alignment: .leading) { HotelPhoto(image: image, height: 105); Text(title).font(.system(size: 12, weight: .medium)); Text("We provide pet friendly room").font(.system(size: 10)).foregroundStyle(AgodaColor.secondary) }.frame(maxWidth: .infinity) }

    private func detailSection(_ title: String, _ lines: [String]) -> some View { VStack(alignment: .leading, spacing: 7) { SectionTitle(title: title, action: "See all"); ForEach(lines, id: \.self) { Text($0).font(.system(size: 12)).foregroundStyle(AgodaColor.secondary) } }.padding(.horizontal, 12).padding(.bottom, 10).overlay(alignment: .top) { AgodaColor.line.frame(height: 0.5) } }

    private var bottomBar: some View { HStack { VStack(alignment: .leading) { Text("Total price for 4 nights").font(.system(size: 10)); Text(tier.roomPrice).font(.system(size: 18, weight: .bold)).foregroundStyle(AgodaColor.red) }; Spacer(); Button("See available rooms", action: onRooms).buttonStyle(.borderedProminent).tint(AgodaColor.blue) }.padding(10).background(Color.white).overlay(alignment: .top) { AgodaColor.line.frame(height: 0.5) } }
}

struct RoomsView: View {
    let tier: VIPTier
    let onBack: () -> Void
    let onDetails: () -> Void
    let onSelect: () -> Void
    var body: some View {
        VStack(spacing: 0) { AgodaNavBar(title: "Paloma Eco Friendly...", onBack: onBack, trailing: ["heart", "square.and.arrow.up"]); ScrollView { LazyVStack(spacing: 18) { room("Superior One Bedroom Apartment", "RoomSuperior", tier.roomPrice, onDetails: onDetails, onSelect: onSelect); room("Executive One Bedroom", "RoomExecutive", "฿ 6,200", onDetails: onDetails, onSelect: onSelect); room("Luxury Suite", "RoomLuxury", "฿ 8,600", onDetails: onDetails, onSelect: onSelect) }.padding(10) }.scrollIndicators(.hidden) }.background(AgodaColor.soft)
    }

    private func room(_ title: String, _ image: String, _ price: String, onDetails: @escaping () -> Void, onSelect: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 8) { HotelPhoto(image: image, height: 180); HStack { VStack(alignment: .leading) { Text(title).font(.system(size: 18, weight: .medium)); Text("20 sq.m.   Max 2+ guests   1 single bed").font(.system(size: 11)) }; Spacer(); Button("Details", action: onDetails).font(.system(size: 11)) }; rateCard("Cheapest", price, onSelect); rateCard("Standard", tier == .gold ? "฿ 18,200" : "฿ 5,200", onSelect) }
    }

    private func rateCard(_ name: String, _ price: String, _ action: @escaping () -> Void) -> some View {
        CardContainer { VStack(alignment: .leading, spacing: 6) { HStack { Text(name).font(.system(size: 13, weight: .medium)); Spacer(); Text(price).font(.system(size: 18, weight: .bold)).foregroundStyle(AgodaColor.red) }; Text("✓ Free Wi-fi\n✓ Pet friendly\n✓ Car park").font(.system(size: 11)).foregroundStyle(AgodaColor.green); HStack { Text("Rooms      1").font(.system(size: 11)); Spacer(); Button("Select", action: action).buttonStyle(.borderedProminent).tint(AgodaColor.blue) } } }
    }
}

struct RoomInfoView: View {
    let tier: VIPTier
    let onBack: () -> Void
    let onPriceDetails: () -> Void
    let onSelect: () -> Void
    var body: some View {
        VStack(spacing: 0) { AgodaNavBar(title: "Superior One Bedroom", onBack: onBack); ScrollView { VStack(spacing: 14) { HotelPhoto(image: "RoomSuperior", height: 260); VStack(alignment: .leading, spacing: 10) { Text("Superior One Bedroom Apartment").font(.system(size: 21, weight: .medium)); Text("20 sq.m. · Max 2 guests · Beach view").font(.system(size: 13)).foregroundStyle(AgodaColor.secondary); BulletRow(symbol: "wifi", text: "Free Wi-fi"); BulletRow(symbol: "mug.fill", text: "Free breakfast"); Button("Price details", action: onPriceDetails).foregroundStyle(AgodaColor.blue); PrimaryButton(title: "Select room", action: onSelect) }.padding(14) }.padding(.bottom, 30) }.scrollIndicators(.hidden) }
    }
}