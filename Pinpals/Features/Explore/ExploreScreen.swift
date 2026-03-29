import SwiftUI

struct ExploreScreen: View {
    @Environment(Router.self) private var router
    @State private var searchText = ""
    @State private var selectedCategory: PlaceCategory?

    var body: some View {
        VStack(spacing: 0) {
            // Search
            PinTextField(placeholder: "Search places, cafes, parks...", text: $searchText, icon: "magnifyingglass")
                .padding(.horizontal, PinSpacing.space4)
                .padding(.vertical, PinSpacing.space3)

            // Category chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: PinSpacing.space2) {
                    PinChip(title: "All", isSelected: selectedCategory == nil) {
                        selectedCategory = nil
                    }
                    ForEach(PlaceCategory.allCases) { category in
                        PinChip(title: category.displayName, isSelected: selectedCategory == category) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, PinSpacing.space4)
            }
            .padding(.bottom, PinSpacing.space3)

            // Place list
            ScrollView {
                LazyVStack(spacing: PinSpacing.space3) {
                    // Place cards will be populated here
                    ContentUnavailableView("No Places Yet", systemImage: "mappin.slash", description: Text("Start exploring and save your favorite places"))
                }
                .padding(.horizontal, PinSpacing.space4)
            }
        }
        .background(Color.Pin.neutral50)
        .navigationTitle("Explore")
    }
}

#Preview {
    NavigationStack {
        ExploreScreen()
    }
    .environment(Router())
}
