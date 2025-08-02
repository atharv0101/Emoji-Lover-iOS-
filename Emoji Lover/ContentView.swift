import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CategoriesView()
                .tabItem { Label("Learn", systemImage: "book.fill") }

            TestGamesView()
                .tabItem { Label("Test", systemImage: "gamecontroller.fill") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        // The .onAppear modifier that was here has been REMOVED.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
