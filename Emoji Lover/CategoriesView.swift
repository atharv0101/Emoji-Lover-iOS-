//
//  CategoriesView.swift
//  Emoji Lover
//
//  Created by Atharv Maheshwari on 31/07/25.
//

import SwiftUI

struct CategoriesView: View {
    // Define the grid layout: 2 columns, with spacing.
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                // The LazyVGrid creates our grid layout.
                LazyVGrid(columns: columns, spacing: 20) {
                    // Loop through all the categories we defined earlier.
                    ForEach(allCategories) { category in
                        // Each category is a link to the learning screen.
                        NavigationLink(destination: LearningCategoryView(title: category.title, items: category.items)) {
                            CategoryCardView(icon: category.icon, title: category.title)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Learn")
        }
        // Use the stack style for standard push navigation.
        .navigationViewStyle(.stack)
    }
}

// It's good practice to create a separate view for the card's design.
struct CategoryCardView: View {
    let icon: String
    let title: String

    var body: some View {
        VStack(spacing: 15) {
            Text(icon)
                .font(.system(size: 60))
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary) // Adapts to light/dark mode
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(Color.primary.opacity(0.05)) // A subtle background
        .cornerRadius(20)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
