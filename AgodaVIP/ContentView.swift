import SwiftUI

struct ContentView: View {
    @State private var route: AppRoute = .home
    @State private var tier: VIPTier = .gold
    @State private var showsPriceDetails = false

    var body: some View {
        ZStack {
            screen
                .id("\(route)-\(tier)")
                .transition(.opacity)
        }
        .animation(.easeOut(duration: 0.3), value: route)
        .preferredColorScheme(.light)
        .sheet(isPresented: $showsPriceDetails) {
            PriceDetailsSheet(tier: tier)
                .presentationDetents([.height(380)])
                .presentationDragIndicator(.visible)
        }
    }

    @ViewBuilder
    private var screen: some View {
        switch route {
        case .home:
            HomeView(tier: tier, onVIP: { route = .vipStatus }, onHotel: { route = .search })
        case .vipStatus:
            VIPStatusView(tier: tier, onBack: { route = .home }, onSearch: { route = .search })
        case .search:
            HotelSearchView(tier: tier, onBack: { route = .home }, onSearch: { route = .results })
        case .results:
            HotelResultsView(tier: tier, onBack: { route = .search }, onHotel: { route = .property })
        case .property:
            PropertyView(tier: tier, onBack: { route = .results }, onRooms: { route = .rooms })
        case .rooms:
            RoomsView(tier: tier, onBack: { route = .property }, onDetails: { route = .roomInfo }, onSelect: { route = .booking })
        case .roomInfo:
            RoomInfoView(tier: tier, onBack: { route = .rooms }, onPriceDetails: { showsPriceDetails = true }, onSelect: { route = .booking })
        case .booking:
            BookingView(tier: tier, onBack: { route = .roomInfo }, onPriceDetails: { showsPriceDetails = true }, onBook: { route = tier == .gold ? .upgrade : .confirmation })
        case .upgrade:
            UpgradeView(onTellMeMore: { tier = .platinum; route = .vipStatus }, onContinue: { tier = .platinum; route = .home })
        case .confirmation:
            ConfirmationView(onHome: { route = .home })
        }
    }
}

#Preview {
    ContentView()
}