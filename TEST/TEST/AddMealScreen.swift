//
//  AddMealScreen.swift
//  TEST
//
//  Created by Christoph Koch-Paiz on 11/2/23.
//

import SwiftUI

struct AddMealScreen: View {
    var body: some View {
        VStack {
            
            Button{
               print("Tapped")
            }label: {
                Label("Add Meal", systemImage: "fork.knife.circle.fill")
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            
        }
    }
}


struct AddMealScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMealScreen()
    }
}
