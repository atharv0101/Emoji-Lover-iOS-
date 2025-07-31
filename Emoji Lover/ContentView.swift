 //
//  ContentView.swift
//  Emoji Lover
//
//  Created by Atharv Maheshwari on 31/07/25.
//

import SwiftUI

enum Emoji: String, CaseIterable{
    case 🥰, 💰, 💪🏼, 💗
}

struct ContentView: View{
    @State var selection : Emoji = .💪🏼
    
    var body: some View {
        NavigationView{
            VStack {
                Text(selection.rawValue)
                    .font(.system(size: 150))
                
                Picker("Select Emoji", selection: $selection) {
                    ForEach(Emoji.allCases, id: \.self) {
                        emoji in Text(emoji.rawValue)
                    }
                }
                .pickerStyle(.segmented) //this displays all emojis in a row
            }
            .navigationTitle("Emojis") //adds title to the screen
            .padding(50)
            
        }
    }
}
    #Preview{
        ContentView()
    }
