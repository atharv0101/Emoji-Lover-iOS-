
//
//  Learning.swift
//  Emoji Lover
//
//  Created by Atharv Maheshwari on 31/07/25.
//

import Foundation
import AVFoundation

struct LearningItem: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
}

// 🍎 Fruits
let fruits: [LearningItem] = [
    LearningItem(emoji: "🍎", name: "Apple"),
    LearningItem(emoji: "🍌", name: "Banana"),
    LearningItem(emoji: "🍒", name: "Cherry"),
    LearningItem(emoji: "🍇", name: "Grapes"),
    LearningItem(emoji: "🥝", name: "Kiwi"),
    LearningItem(emoji: "🍋", name: "Lemon"),
    LearningItem(emoji: "🥭", name: "Mango"),
    LearningItem(emoji: "🍊", name: "Orange"),
    LearningItem(emoji: "🍑", name: "Peach"),
    LearningItem(emoji: "🍍", name: "Pineapple"),
    LearningItem(emoji: "🍓", name: "Strawberry"),
    LearningItem(emoji: "🍉", name: "Watermelon")
]


// 🥦 Vegetables
let vegetables: [LearningItem] = [
    LearningItem(emoji: "🥑", name: "Avocado"),
    LearningItem(emoji: "🥦", name: "Broccoli"),
    LearningItem(emoji: "🥕", name: "Carrot"),
    LearningItem(emoji: "🌶️", name: "Chilli"),
    LearningItem(emoji: "🥒", name: "Cucumber"),
    LearningItem(emoji: "🧄", name: "Garlic"),
    LearningItem(emoji: "🧅", name: "Onion"),
    LearningItem(emoji: "🥔", name: "Potato"),
    LearningItem(emoji: "🍅", name: "Tomato")
]


// 🐶 Animals
let animals: [LearningItem] = [
    LearningItem(emoji: "🐻", name: "Bear"),
    LearningItem(emoji: "🐈", name: "Cat"),
    LearningItem(emoji: "🐄", name: "Cow"),
    LearningItem(emoji: "🦮", name: "Dog"),
    LearningItem(emoji: "🐘", name: "Elephant"),
    LearningItem(emoji: "🦊", name: "Fox"),
    LearningItem(emoji: "🐐", name: "Goat"),
    LearningItem(emoji: "🦒", name: "Giraffe"),
    LearningItem(emoji: "🐎", name: "Horse"),
    LearningItem(emoji: "🦁", name: "Lion"),
    LearningItem(emoji: "🐼", name: "Panda"),
    LearningItem(emoji: "🐇", name: "Rabbit")
]

