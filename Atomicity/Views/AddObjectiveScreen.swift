//
//  AddObjectiveScreen.swift
//  Atomicity
//
//  Created by Joseph DeWeese on 10/8/24.
//

import SwiftUI

struct AddObjectiveScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @State private var title = ""
    @State private var briefDescription = ""
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Objective Title", text:$title)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(7.5))
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                  
                TextField("Brief Description", text: $briefDescription)
                    .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(7.5))
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.horizontal, 15)
                .padding(.vertical,5)
             
            }
            .padding(.horizontal)
            Spacer()
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            HapticManager.notification(type: .success)
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        
                    HeaderView()
                    }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newObjective = Objective(title: title, briefDescription: briefDescription)
                        context.insert(newObjective)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                   .disabled(title.isEmpty || briefDescription.isEmpty)
                }
            }
        }
    }
}
    
#Preview {
    AddObjectiveScreen()
}
