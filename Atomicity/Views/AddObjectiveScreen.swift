//
//  AddObjectiveScreen.swift
//  Atomicity
//
//  Created by Joseph DeWeese on 10/8/24.
//

import SwiftUI

struct AddObjectiveScreen: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Objective Title", text:.constant(""))
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(7.5))
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                  
                TextField("Brief Description", text: .constant(""))
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
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        
                    HeaderView()
                    }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
//                        let newProject = Project(title: title, briefDescription: briefDescription)
//                        context.insert(newProject)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
      //             .disabled(title.isEmpty || briefDescription.isEmpty)
                }
            }
        }
    }
}
    
#Preview {
    AddObjectiveScreen()
}
