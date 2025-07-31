import Foundation

// LearningItem must be defined FIRST...
struct LearningItem: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
}

// ...so that LearningCategory can use it.
struct LearningCategory: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let items: [LearningItem]
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

// 🔢 Numbers
let numbers: [LearningItem] = [
    LearningItem(emoji: "1️⃣", name: "One"),
    LearningItem(emoji: "2️⃣", name: "Two"),
    LearningItem(emoji: "3️⃣", name: "Three"),
    LearningItem(emoji: "4️⃣", name: "Four"),
    LearningItem(emoji: "5️⃣", name: "Five"),
    LearningItem(emoji: "6️⃣", name: "Six"),
    LearningItem(emoji: "7️⃣", name: "Seven"),
    LearningItem(emoji: "8️⃣", name: "Eight"),
    LearningItem(emoji: "9️⃣", name: "Nine"),
    LearningItem(emoji: "🔟", name: "Ten")
]

// 🔶 Shapes
let shapes: [LearningItem] = [
    LearningItem(emoji: "🔴", name: "Circle"),
    LearningItem(emoji: "🔵", name: "Square"),
    LearningItem(emoji: "🔺", name: "Triangle"),
    LearningItem(emoji: "⭐", name: "Star"),
    LearningItem(emoji: "❤️", name: "Heart"),
    LearningItem(emoji: "♦️", name: "Diamond")
]

// 🎨 Colors
let colors: [LearningItem] = [
    LearningItem(emoji: "❤️", name: "Red"),
    LearningItem(emoji: "🧡", name: "Orange"),
    LearningItem(emoji: "💛", name: "Yellow"),
    LearningItem(emoji: "💚", name: "Green"),
    LearningItem(emoji: "💙", name: "Blue"),
    LearningItem(emoji: "💜", name: "Purple"),
    LearningItem(emoji: "🖤", name: "Black"),
    LearningItem(emoji: "🤍", name: "White"),
    LearningItem(emoji: "🤎", name: "Brown")
]

// The master list of all categories
let allCategories: [LearningCategory] = [
    LearningCategory(title: "Fruits", icon: "🍎", items: fruits),
    LearningCategory(title: "Animals", icon: "🐶", items: animals),
    LearningCategory(title: "Numbers", icon: "🔢", items: numbers),
    LearningCategory(title: "Shapes", icon: "🔶", items: shapes),
    LearningCategory(title: "Colors", icon: "🎨", items: colors),
    LearningCategory(title: "Vegetables", icon: "🥦", items: vegetables)
]
