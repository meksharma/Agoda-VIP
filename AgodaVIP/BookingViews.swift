import SwiftUI

struct BookingView: View {
    let tier: VIPTier
    let onBack: () -> Void
    let onPriceDetails: () -> Void
    let onBook: () -> Void
    @State private var largeBed = true
    @State private var nonSmoking = true

    var body: some View {
        VStack(spacing: 0) {
            AgodaNavBar(title: "Payment details", onBack: onBack)
            ScrollView {
                LazyVStack(spacing: 0) {
                    Text("We are holding your price...                 00:19:56").font(.system(size: 10, weight: .medium)).foregroundStyle(.white).frame(maxWidth: .infinity).padding(5).background(AgodaColor.red)
                    hotelSummary
                    guest
                    payment
                    requests
                    terms
                }
            }.scrollIndicators(.hidden)
        }
        .safeAreaInset(edge: .bottom) { VStack(spacing: 5) { Text("Great choice! You're getting free cancellation.").font(.system(size: 10)).foregroundStyle(.white).padding(5).frame(maxWidth: .infinity).background(AgodaColor.green); PrimaryButton(title: "Slide to book", action: onBook) }.padding(8).background(Color.white) }
    }

    private var hotelSummary: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) { Image("BookingHotel").resizable().scaledToFill().frame(width: 74, height: 68).clipped().clipShape(RoundedRectangle(cornerRadius: 8)); VStack(alignment: .leading) { Text("Paloma Eco Friendly Luxury Pool").font(.system(size: 15, weight: .medium)); Text("★★★★★  9.1 Excellent").font(.system(size: 10)).foregroundStyle(AgodaColor.blue) } }
            HStack { detail("Tue, Sep 4", "15:00"); Image(systemName: "arrow.right"); detail("Sat, Sep 8", "12:00"); Spacer(); detail("4", "nights") }.padding(10).overlay { RoundedRectangle(cornerRadius: 9).stroke(AgodaColor.line) }
            Text("👍 96% of guests recommend this property").font(.system(size: 11)).foregroundStyle(AgodaColor.green).padding(8).frame(maxWidth: .infinity).background(Color.green.opacity(0.15), in: Capsule())
            HStack { Image("BookingRoom").resizable().scaledToFill().frame(width: 70, height: 54).clipped().clipShape(RoundedRectangle(cornerRadius: 6)); VStack(alignment: .leading) { Text("1 x Superior One Bedroom Apartment").font(.system(size: 12, weight: .medium)); Text("✓ Free Wi-fi\n✓ Free breakfast").font(.system(size: 10)).foregroundStyle(AgodaColor.green) } }
            Button(action: onPriceDetails) { HStack { VStack(alignment: .leading) { Text("Total").font(.system(size: 13)); Text("4 nights with taxes").font(.system(size: 10)).foregroundStyle(AgodaColor.secondary) }; Spacer(); Text(tier.roomPrice).font(.system(size: 20, weight: .bold)) } }.buttonStyle(.plain)
        }.padding(12)
    }

    private func detail(_ top: String, _ bottom: String) -> some View { VStack { Text(top).font(.system(size: 11)); Text(bottom).font(.system(size: 9)).foregroundStyle(AgodaColor.secondary) } }
    private var guest: some View { VStack(alignment: .leading, spacing: 8) { SectionTitle(title: "Guest"); HStack { Text("🙂"); VStack(alignment: .leading) { Text("Mehak Sharma").font(.system(size: 13, weight: .medium)); Text("+66 0800039142").font(.system(size: 10)) } }; HStack { Text("Make this booking for someone else").font(.system(size: 11)); Spacer(); Text("Add").foregroundStyle(AgodaColor.blue) } }.padding(.horizontal, 12).padding(.bottom, 12).overlay(alignment: .top) { AgodaColor.line.frame(height: 0.5) } }

    private var payment: some View {
        VStack(alignment: .leading, spacing: 10) { SectionTitle(title: "Payment details"); Text("🛡 Secure payment\nAll payment data is fully encrypted and protected").font(.system(size: 11)).foregroundStyle(AgodaColor.green); HStack { Text("Enter credit/debit card").font(.system(size: 12)); Spacer(); Text("Change payment").font(.system(size: 11)).foregroundStyle(AgodaColor.blue) }; ForEach(["Card number", "Name on card", "Expiry date        CVC", "Name of bank"], id: \.self) { placeholder in Text(placeholder).font(.system(size: 11)).foregroundStyle(AgodaColor.secondary).padding(12).frame(maxWidth: .infinity, alignment: .leading).overlay { RoundedRectangle(cornerRadius: 6).stroke(AgodaColor.line) } }; Toggle("Save this card", isOn: .constant(true)).font(.system(size: 11)) }.padding(.horizontal, 12).padding(.bottom, 14).overlay(alignment: .top) { AgodaColor.line.frame(height: 0.5) }
    }

    private var requests: some View {
        VStack(alignment: .leading, spacing: 4) { SectionTitle(title: "Special request"); Text("Please select your preference\nSubject to availability").font(.system(size: 10)).foregroundStyle(AgodaColor.red); Toggle("Large bed", isOn: $largeBed); Toggle("Twin beds", isOn: Binding(get: { !largeBed }, set: { largeBed = !$0 })); Toggle("Non-smoking room", isOn: $nonSmoking); Toggle("Smoking room", isOn: Binding(get: { !nonSmoking }, set: { nonSmoking = !$0 })); Text("Any personal requests?").font(.system(size: 11)); Text("Personal requests\nE.g. late/early check-in, high floor, etc...").font(.system(size: 10)).foregroundStyle(AgodaColor.secondary).padding(10).frame(maxWidth: .infinity, alignment: .leading).overlay { RoundedRectangle(cornerRadius: 6).stroke(AgodaColor.line) } }.toggleStyle(.button).font(.system(size: 12)).padding(.horizontal, 12).padding(.bottom, 14).overlay(alignment: .top) { AgodaColor.line.frame(height: 0.5) }
    }
    private var terms: some View { Text("By proceeding, I agree to Agoda's terms of use and acknowledge their privacy policy.").font(.system(size: 10)).foregroundStyle(AgodaColor.secondary).padding(12) }
}

struct PriceDetailsSheet: View {
    let tier: VIPTier
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 14) { HStack { Button(action: { dismiss() }) { Image(systemName: "xmark").font(.title2) }; Spacer(); Text("Price details").font(.system(size: 18, weight: .semibold)); Spacer(); Color.clear.frame(width: 24) }.padding(); Divider(); Text("Superior One Bedroom Apartment").font(.system(size: 15, weight: .medium)); HStack { Text("1 room X 4 nights"); Spacer(); Text("฿ 13,124") }; VIPBadge(tier: tier); HStack { Text("Free Breakfast"); Spacer() }; HStack { Text("VIP Discount"); Spacer(); Text("-฿ \(tier == .gold ? "100" : "9,743")") }; HStack { Text("Taxes and fees"); Spacer(); Text("฿ 900") }; Divider(); HStack { Text("Trip Total").font(.system(size: 18)); Spacer(); Text(tier.roomPrice).font(.system(size: 22, weight: .bold)) } }.font(.system(size: 14)).padding(.horizontal, 22).foregroundStyle(AgodaColor.ink)
    }
}

struct UpgradeView: View {
    let onTellMeMore: () -> Void
    let onContinue: () -> Void
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LinearGradient(colors: [Color(red: 0.72, green: 0.77, blue: 1), Color(red: 0.88, green: 0.9, blue: 1)], startPoint: .top, endPoint: .bottom).frame(height: 104).overlay(alignment: .leading) { VStack(alignment: .leading, spacing: 5) { VIPBadge(tier: .platinum); Text("Congratulations! You just got upgraded to VIP Platinum!\nTell me more!").font(.system(size: 13, weight: .bold)).foregroundStyle(AgodaColor.platinum).onTapGesture(perform: onTellMeMore) }.padding(12) }
                VStack(alignment: .leading, spacing: 8) { Text("Booking details").font(.system(size: 16, weight: .medium)); Text("🗓 Tue, Sep 4 – Sat, Sep 8 2021 (4 nights)\n1 x Superior One Bedroom Apartment\n2 adults\n✓ Free cancellation before Sep 3").font(.system(size: 11)).foregroundStyle(AgodaColor.secondary) }.padding(12).frame(maxWidth: .infinity, alignment: .leading)
                SectionTitle(title: "Price summary")
                VStack(alignment: .leading, spacing: 7) { Text("Superior One Bedroom Apartment"); Text("Free Breakfast Included").foregroundStyle(AgodaColor.green); Text("AgodaVIP Platinum                  -฿ 100").foregroundStyle(AgodaColor.green); HStack { Text("Total"); Spacer(); Text("฿ 13,924").font(.system(size: 18, weight: .bold)) } }.font(.system(size: 11)).padding(12)
                SectionTitle(title: "Property info")
                HStack { Image("UpgradeHotel").resizable().scaledToFill().frame(width: 78, height: 72).clipped().clipShape(RoundedRectangle(cornerRadius: 8)); VStack(alignment: .leading) { Text("Paloma Eco Friendly Luxury Pool").font(.system(size: 14, weight: .medium)); Text("★★★★★\n9.1 Excellent").font(.system(size: 10)).foregroundStyle(AgodaColor.blue) } }.padding(12)
                SectionTitle(title: "Recommended for")
                Text("Relaxation / beach\nRestaurant / dining\nTop attractions nearby\nCentral World (700 m / 9 min walk)\nNearest transport\nDistance to airport: 23.0 km").font(.system(size: 11)).foregroundStyle(AgodaColor.secondary).frame(maxWidth: .infinity, alignment: .leading).padding(12)
                SectionTitle(title: "Self-service")
                Text("Change my dates    ·    Cancel my booking\nResend my voucher  ·    Add special requests\nGet my receipt     ·    View all my bookings").font(.system(size: 11)).padding(12)
                PrimaryButton(title: "Back to home", action: onContinue).padding(16)
            }
        }.scrollIndicators(.hidden)
    }
}

struct ConfirmationView: View {
    let onHome: () -> Void
    var body: some View {
        ScrollView { VStack(spacing: 0) { LinearGradient(colors: [Color(red: 0.72, green: 0.77, blue: 1), .white], startPoint: .top, endPoint: .bottom).frame(height: 120).overlay(alignment: .leading) { VStack(alignment: .leading) { VIPBadge(tier: .platinum); Text("Thank you for booking with Agoda!\nYour booking is paid and confirmed").font(.system(size: 13, weight: .bold)).foregroundStyle(AgodaColor.platinum) }.padding(12) }; VStack(alignment: .leading, spacing: 12) { SectionTitle(title: "Booking details"); Text("🗓 Tue, Sep 4 – Sat, Sep 8 2021 (4 nights)\n1 x Superior One Bedroom Apartment\n2 adults").font(.system(size: 11)); SectionTitle(title: "Price summary"); HStack { Text("Total"); Spacer(); Text("฿ 13,924").font(.system(size: 18, weight: .bold)) }; SectionTitle(title: "Property info"); HStack { Image("UpgradeHotel").resizable().scaledToFill().frame(width: 78, height: 72).clipped().clipShape(RoundedRectangle(cornerRadius: 8)); Text("Paloma Eco Friendly Luxury Pool\n★★★★★\n9.1 Excellent").font(.system(size: 12)) }; SectionTitle(title: "Recommended for"); Text("Relaxation / beach\nRestaurant / dining\nTop attractions nearby\nNearest transport\nDistance to airport: 23.0 km").font(.system(size: 11)).foregroundStyle(AgodaColor.secondary); SectionTitle(title: "Self-service"); Text("Change my dates · Cancel my booking\nManage my voucher · Add special requests").font(.system(size: 11)); PrimaryButton(title: "Back to home", action: onHome) }.padding(12) } }.scrollIndicators(.hidden)
    }
}