import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        TabView {
            LearningCategoryView(title: "Fruits", items: fruits)
                .tabItem {
                    Label("Fruits", systemImage: "applelogo")
                }

            LearningCategoryView(title: "Vegetables", items: vegetables)
                .tabItem {
                    Label("Veggies", systemImage: "leaf")
                }

            LearningCategoryView(title: "Animals", items: animals)
                .tabItem {
                    Label("Animals", systemImage: "pawprint.fill")
                }
            
            // Add the SettingsView as a new tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        
        }
    }
}

#Preview {
    ContentView()
}
