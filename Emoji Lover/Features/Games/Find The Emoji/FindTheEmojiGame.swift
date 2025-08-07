import Foundation

struct FindTheEmojiQuestion: Identifiable {
    let id = UUID()
    let correctAnswer: LearningItem
    let options: [LearningItem]
    let prompt: String
}

class FindTheEmojiViewModel: ObservableObject {
    @Published private(set) var questions: [FindTheEmojiQuestion] = []
    @Published private(set) var currentQuestionIndex: Int = 0
    @Published private(set) var score: Int = 0
    @Published private(set) var questionResults: [Bool] = []
    
    var isGameOver: Bool {
        (!questions.isEmpty && currentQuestionIndex >= questions.count)
    }
    
    var currentQuestion: FindTheEmojiQuestion? {
        isGameOver || questions.isEmpty ? nil : questions[currentQuestionIndex]
    }
    
    var starRating: Int {
        guard isGameOver else { return 0 }
        let percentage = Double(score) / Double(questions.count)
        if percentage >= 0.9 { return 3 }
        else if percentage >= 0.6 { return 2 }
        else if score > 0 { return 1 }
        else { return 0 }
    }

    func createGame(from category: LearningCategory, difficulty: Difficulty) {
        let allItemsInSelectedCategory = category.items.shuffled()
        let numberOfQuestions = 5
        
        var gameQuestions: [FindTheEmojiQuestion] = []
        let itemsForQuestions = allItemsInSelectedCategory.prefix(numberOfQuestions)
        
        for item in itemsForQuestions {
            var options = [item]
            
            // --- LOGIC FOR CONTEXTUAL DISTRACTORS ---
            var sourceForDistractors: [LearningItem]
            
            // If the game is "Mixed", find the original category of the correct answer.
            if category.title == "Mixed" {
                if fruits.contains(where: { $0.id == item.id }) {
                    sourceForDistractors = fruits
                } else if animals.contains(where: { $0.id == item.id }) {
                    sourceForDistractors = animals
                } else if numbers.contains(where: { $0.id == item.id }) {
                    sourceForDistractors = numbers
                } else if shapes.contains(where: { $0.id == item.id }) {
                    sourceForDistractors = shapes
                } else if colors.contains(where: { $0.id == item.id }) {
                    sourceForDistractors = colors
                } else if vegetables.contains(where: { $0.id == item.id }) {
                    sourceForDistractors = vegetables
                } else {
                    sourceForDistractors = allItemsInSelectedCategory // Fallback
                }
            } else {
                // If it's a normal category, just use its own items.
                sourceForDistractors = allItemsInSelectedCategory
            }

            let distractors = sourceForDistractors.filter { $0.id != item.id }.shuffled()
            
            let numberOfDistractors: Int
            switch difficulty {
            case .easy: numberOfDistractors = 1
            case .medium: numberOfDistractors = 3
            case .hard: numberOfDistractors = 5
            }
            
            let availableDistractors = distractors.prefix(numberOfDistractors)
            options.append(contentsOf: availableDistractors)
            
            if options.count == numberOfDistractors + 1 {
                let question = FindTheEmojiQuestion(
                    correctAnswer: item,
                    options: options.shuffled(),
                    prompt: "Find the \(item.name)"
                )
                gameQuestions.append(question)
            }
        }
        
        self.questions = gameQuestions
        self.currentQuestionIndex = 0
        self.score = 0
        self.questionResults = []
    }
    
    func submitAnswer(for chosenItem: LearningItem) {
        guard let currentQuestion = currentQuestion else { return }
        
        let isCorrect = (chosenItem.id == currentQuestion.correctAnswer.id)
        questionResults.append(isCorrect)
        
        if isCorrect {
            score += 1
            HapticManager.instance.notification(type: .success)
            SoundManager.instance.playSound(named: "match", withExtension: "aif")
        } else {
            HapticManager.instance.notification(type: .error)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.currentQuestionIndex += 1
        }
    }
}
