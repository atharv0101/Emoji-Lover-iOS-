import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // The "Learn" tab now shows our new category grid screen.
            CategoriesView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }

            // The "Settings" tab remains the same.
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
