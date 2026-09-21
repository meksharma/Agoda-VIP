import SwiftUI

struct AgodaNavBar: View {
    let title: String
    let onBack: (() -> Void)?
    var trailing: [String] = []

    var body: some View {
        HStack {
            if let onBack {
                Button(action: onBack) { Image(systemName: "chevron.left").font(.system(size: 18, weight: .medium)).frame(width: 32, height: 32) }.buttonStyle(.plain)
            } else { Color.clear.frame(width: 32, height: 32) }
            Text(title).font(.system(size: 16, weight: .medium)).lineLimit(1).frame(maxWidth: .infinity)
            HStack(spacing: 16) { ForEach(trailing, id: \.self) { Image(systemName: $0).font(.system(size: 17)) } }.frame(minWidth: 32, alignment: .trailing)
        }
        .foregroundStyle(AgodaColor.ink).padding(.horizontal, 8).frame(height: 44).background(Color.white)
        .overlay(alignment: .bottom) { AgodaColor.line.frame(height: 0.5) }
    }
}

struct VIPBadge: View {
    let tier: VIPTier
    var body: some View {
        HStack(spacing: 3) {
            Text("★ VIP").foregroundStyle(.white).padding(.leading, 5)
            Text(tier.rawValue).foregroundStyle(tier == .gold ? AgodaColor.ink : .white).padding(.horizontal, 5)
        }
        .font(.system(size: 11, weight: .bold)).frame(height: 20)
        .background { HStack(spacing: 0) { AgodaColor.darkVIP; tier.accent } }
        .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title).font(.system(size: 16, weight: .medium)).foregroundStyle(.white).frame(maxWidth: .infinity).frame(height: 48).background(AgodaColor.blue, in: Capsule())
        }.buttonStyle(.plain)
    }
}

struct SectionTitle: View {
    let title: String
    var action: String? = nil
    var body: some View {
        HStack { Text(title).font(.system(size: 17, weight: .medium)); Spacer(); if let action { Text(action).font(.system(size: 12)).foregroundStyle(AgodaColor.blue) } }
            .foregroundStyle(AgodaColor.ink).padding(.horizontal, 12).padding(.top, 16).padding(.bottom, 8)
    }
}

struct HotelPhoto: View {
    let image: String
    var height: CGFloat
    var body: some View { Image(image).resizable().scaledToFill().frame(maxWidth: .infinity).frame(height: height).clipped().clipShape(RoundedRectangle(cornerRadius: 10)) }
}

struct BulletRow: View {
    let symbol: String
    let text: String
    var color: Color = AgodaColor.green
    var body: some View {
        HStack(spacing: 8) { Image(systemName: symbol).font(.system(size: 13, weight: .semibold)).foregroundStyle(color).frame(width: 20); Text(text).font(.system(size: 13)); Spacer() }.foregroundStyle(AgodaColor.ink)
    }
}

struct CardContainer<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View { content.padding(12).background(Color.white, in: RoundedRectangle(cornerRadius: 12)).overlay { RoundedRectangle(cornerRadius: 12).stroke(AgodaColor.line) }.shadow(color: .black.opacity(0.08), radius: 4, y: 1) }
}