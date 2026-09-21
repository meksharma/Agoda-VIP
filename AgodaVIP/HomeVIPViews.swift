import SwiftUI

struct HomeView: View {
    let tier: VIPTier
    let onVIP: () -> Void
    let onHotel: () -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                HStack {
                    Image("AgodaLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 74, height: 38)
                    Spacer(); Image(systemName: "person.crop.circle"); Image(systemName: "wallet.pass").padding(.leading, 14)
                }.padding(.horizontal, 14).frame(height: 48)
                entryTile
                if tier == .gold {
                    Button(action: onVIP) { figmaSection("HomeVIPGoldSection", ratio: 375 / 108) }.buttonStyle(.plain)
                } else {
                    vipPanel
                }
                figmaSection("HomePromotionsSection", ratio: 375 / 200)
                figmaSection("HomeBookingSection", ratio: 375 / 84)
                ScrollView(.horizontal) {
                    Image("HomeUpcomingSection").resizable().frame(width: 673, height: 150)
                }.scrollIndicators(.hidden)
                figmaSection("HomeRecentSection", ratio: 359 / 226).padding(.horizontal, 8)
                figmaSection("HomeDealSection", ratio: 375 / 84)
                figmaSection("HomeCashSection", ratio: 375 / 108)
                figmaSection("HomeDestinationsSection", ratio: 359 / 244).padding(.horizontal, 8)
                figmaSection("HomePaymentSection", ratio: 375 / 112)
                figmaSection("HomeHomesSection", ratio: 375 / 184)
                featuredCards
                Color.clear.frame(height: 70)
            }
        }.scrollIndicators(.hidden).background(Color.white).safeAreaInset(edge: .bottom, spacing: 0) { HomeTabBar() }
    }

    private var entryTile: some View {
        ZStack(alignment: .topLeading) {
            Image("HomeEntryTile")
                .resizable()
                .frame(width: 343, height: 256)
            Button(action: onHotel) {
                Color.clear
                    .frame(width: 205, height: 140)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .frame(width: 343, height: 256)
    }

    private var vipPanel: some View {
        Button(action: onVIP) {
            HStack { VStack(alignment: .leading, spacing: 5) { Text("VIP status").font(.system(size: 13)); Text(tier == .gold ? "You're getting up to 18% booking discount" : "Congratulations! Platinum gives up to 25% off").font(.system(size: 11)).foregroundStyle(AgodaColor.secondary).multilineTextAlignment(.leading) }; Spacer(); VIPBadge(tier: tier) }
                .padding(12).background(Color.white, in: RoundedRectangle(cornerRadius: 10)).overlay { RoundedRectangle(cornerRadius: 10).stroke(AgodaColor.line) }
        }.buttonStyle(.plain).padding(12)
    }

    private func figmaSection(_ image: String, ratio: CGFloat) -> some View {
        Image(image)
            .resizable()
            .aspectRatio(ratio, contentMode: .fit)
            .frame(maxWidth: .infinity)
    }

    private var featuredCards: some View {
        VStack(spacing: 8) {
            SectionTitle(title: "Featured Agoda Homes")
            LazyVGrid(columns: [GridItem(.fixed(165)), GridItem(.fixed(165))], spacing: 12) {
                ForEach(["HomeFeaturedCard1", "HomeFeaturedCard3", "HomeFeaturedCard2", "HomeFeaturedCard4"], id: \.self) { image in
                    Button(action: onHotel) {
                        Image(image).resizable().frame(width: 165, height: 220)
                    }.buttonStyle(.plain)
                }
            }
        }
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