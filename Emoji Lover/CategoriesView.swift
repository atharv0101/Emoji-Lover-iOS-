import SwiftUI

struct CategoriesView: View {
    // Defines the 2-column grid layout
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(allCategories) { category in
                        // Use a standard NavigationLink for the slide-in transition
                        NavigationLink(destination: LearningCategoryView(title: category.title, items: category.items)) {
                            CategoryCardView(icon: category.icon, title: category.title)
                        }
                        .buttonStyle(GrowButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Learn")
        }
        .navigationViewStyle(.stack)
    }
}

// Defines the visual design of each card in the grid
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
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(Color.primary.opacity(0.05))
        .cornerRadius(20)
    }
}

// Defines the "grow on tap" animation style for the buttons
struct GrowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}

