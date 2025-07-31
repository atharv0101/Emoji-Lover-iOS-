import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // The "Learn" tab shows our category grid screen.
            CategoriesView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }

            // The "Settings" tab shows the settings screen.
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

