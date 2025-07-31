 //
//  ContentView.swift
//  Emoji Lover
//
//  Created by Atharv Maheshwari on 31/07/25.
//

import SwiftUI
import AVFoundation
struct ContentView: View{
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
                }
            
        }
    }

    #Preview{
        ContentView()
    }
