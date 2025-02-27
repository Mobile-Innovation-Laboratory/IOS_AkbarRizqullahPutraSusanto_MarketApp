//
//  Chip.swift
//  DummyJSON
//
//  Created by Irham Naufal on 02/02/25.
//

import SwiftUI

struct Chip: View {
    
    let text: String
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.headline)
                .foregroundStyle(.black)
                .padding(5)
                .padding(.horizontal, 8)
                .background(bgColor.opacity(0.1))
                .clipShape(Capsule())
        }
    }
}

#Preview {
    HStack {
        Chip(
            text: "All",
            bgColor: Color.gray
        ) {
            
        }
        
        Chip(
            text: "Smartphone",
            bgColor: Color.blue
        ) {
            
        }
    }
}
