import SwiftUI

struct MemoryMatchSetupView: View {
    var onStartGame: (LearningCategory, Difficulty) -> Void
    
    @State private var selectedCategory: LearningCategory? = gameCategories.first
    @State private var selectedDifficulty: Difficulty = .medium
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("Game Setup")
                .font(.largeTitle).bold()
                .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 15) {
                Text("Choose a Category").font(.title2).bold()
                
                ScrollViewReader { proxy in
                    ZStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(gameCategories) { category in
                                    CategorySelectionCard(
                                        category: category,
                                        isSelected: selectedCategory?.id == category.id
                                    )
                                    .onTapGesture { selectedCategory = category }
                                    .id(category.id)
                                }
                            }
                        }
                        
                        HStack {
                            if let selected = selectedCategory, let currentIndex = gameCategories.firstIndex(where: { $0.id == selected.id }), currentIndex > 0 {
                                Button(action: {
                                    let newIndex = currentIndex - 1
                                    selectedCategory = gameCategories[newIndex]
                                    withAnimation { proxy.scrollTo(gameCategories[newIndex].id, anchor: .center) }
                                }) { Image(systemName: "chevron.left.circle.fill").font(.title) }
                                    .transition(.opacity.combined(with: .scale))
                            }
                            
                            Spacer()
                            
                            if let selected = selectedCategory, let currentIndex = gameCategories.firstIndex(where: { $0.id == selected.id }), currentIndex < gameCategories.count - 1 {
                                Button(action: {
                                    let newIndex = currentIndex + 1
                                    selectedCategory = gameCategories[newIndex]
                                    withAnimation { proxy.scrollTo(gameCategories[newIndex].id, anchor: .center) }
                                }) { Image(systemName: "chevron.right.circle.fill").font(.title) }
                                    .transition(.opacity.combined(with: .scale))
                            }
                        }
                        .foregroundColor(.accentColor.opacity(0.6))
                        .padding(.horizontal, -15)
                    }
                    .animation(.default, value: selectedCategory)
                }
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Select Difficulty").font(.title2).bold()
                Picker("Difficulty", selection: $selectedDifficulty) {
                    ForEach(Difficulty.allCases) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(.segmented)
            }

            Spacer()

            Button(action: {
                if let category = selectedCategory {
                    onStartGame(category, selectedDifficulty)
                }
            }) {
                Text("Start Game")
                    .font(.headline).fontWeight(.bold).foregroundColor(.white).padding()
                    .frame(maxWidth: .infinity).background(selectedCategory != nil ? Color.blue : Color.gray).cornerRadius(15)
            }
            .buttonStyle(SpringyButtonStyle())
            .disabled(selectedCategory == nil)
        }
        .padding(30)
    }
}

struct CategorySelectionCard: View {
    let category: LearningCategory
    let isSelected: Bool

    var body: some View {
        VStack {
            Text(category.icon)
                .font(.largeTitle)
            Text(category.title)
                .font(.caption)
                .fontWeight(.bold)
        }
        .padding(8)
        .frame(width: 100, height: 100)
        .background(isSelected ? Color.accentColor.opacity(0.2) : Color.primary.opacity(0.05))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 3)
        )
        .animation(.spring(), value: isSelected)
    }
}

struct MemoryMatchSetupView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryMatchSetupView(onStartGame: {_,_ in })
    }
}
