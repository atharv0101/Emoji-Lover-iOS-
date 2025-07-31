
//
//  Learning.swift
//  Emoji Lover
//
//  Created by Atharv Maheshwari on 31/07/25.
//

import Foundation

struct LearningItem: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
}

// 🍎 Fruits
let fruits: [LearningItem] = [
    LearningItem(emoji: "🍎", name: "Apple"),
    LearningItem(emoji: "🍌", name: "Banana"),
    LearningItem(emoji: "🍇", name: "Grapes")
]

// 🥦 Vegetables
let vegetables: [LearningItem] = [
    LearningItem(emoji: "🥕", name: "Carrot"),
    LearningItem(emoji: "🥦", name: "Broccoli"),
    LearningItem(emoji: "🌽", name: "Corn")
]

// 🐶 Animals
let animals: [LearningItem] = [
    LearningItem(emoji: "🐶", name: "Dog"),
    LearningItem(emoji: "🐱", name: "Cat"),
    LearningItem(emoji: "🐘", name: "Elephant")
]
