import Foundation
import Services
import SwiftUI

@MainActor
public struct LibrarySplitView: View {
  @EnvironmentObject var audioController: AudioController

  @StateObject private var inboxViewModel = HomeFeedViewModel(
    folder: "inbox",
    fetcher: LibraryItemFetcher(),
    listConfig: LibraryListConfig(
      hasFeatureCards: true,
      leadingSwipeActions: [.pin],
      trailingSwipeActions: [.archive, .delete],
      cardStyle: .library
    )
  )

  @StateObject private var followingViewModel = HomeFeedViewModel(
    folder: "following",
    fetcher: LibraryItemFetcher(),
    listConfig: LibraryListConfig(
      hasFeatureCards: false,
      leadingSwipeActions: [.moveToInbox],
      trailingSwipeActions: [.archive, .delete],
      cardStyle: .library
    )
  )

  @State var selected = "home"

  #if os(iOS)
    public var body: some View {
      NavigationView {
        LibrarySidebar(inboxViewModel: inboxViewModel, followingViewModel: followingViewModel)
          .navigationBarTitleDisplayMode(.inline)
          .tag("inbox")

        HomeFeedContainerView(viewModel: inboxViewModel)
          .navigationViewStyle(.stack)
          .navigationBarTitleDisplayMode(.inline)
          .tag("following")
      }
      .navigationBarTitleDisplayMode(.inline)
      .accentColor(.appGrayTextContrast)
      .introspectSplitViewController {
        $0.preferredPrimaryColumnWidth = 230
        $0.displayModeButtonVisibility = .always
      }
    }
  #endif

  #if os(macOS)
    public var body: some View {
      NavigationView {
        LibraryListView()
        Text(LocalText.navigationSelectLink)
      }
    }
  #endif
}
