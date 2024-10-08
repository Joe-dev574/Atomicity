//
//  ContentView.swift
//  Atomicity
//
//  Created by Joseph DeWeese on 10/8/24.
//

import SwiftUI
import SwiftData


enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, title, briefDescription
    
    var id: Self {
        self
    }
}
struct ContentView: View {
   
    @State var width = UIScreen.main.bounds.width
    @State private var createNewProject = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack{
                NavigationSplitView {
                    ObjectivesListView(sortOrder: sortOrder, filterString: filter)
#if os(macOS)
                        .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
                        //MARK:  TOOL BAR
                        .toolbar {
#if os(iOS)
                            ToolbarItem(placement: .topBarLeading) {
                                Button{
                                    print(" go to profile link")
                                    HapticManager.notification(type: .success)
                                } label: {
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.title)
                                        .foregroundStyle(.gray)
                                }
                            }
#endif
                            ToolbarItem(placement: .principal, content: {
                                HeaderView( ).padding(.trailing, 30)
                            })
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    createNewProject = true
                                    HapticManager.notification(type: .success)
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(Color.gray)
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                    }
                                }
                                
                            }
                        }
                        //MARK:  SHEET IS PRESENTED - ADD OBJECTIVE
                        .sheet(isPresented: $createNewProject) {
                            AddObjectiveScreen()
                                .presentationDetents([.height(350)])
                        }
                }detail: {

                }
                                        
            }
        }
    }
    }

#Preview {
    ContentView()
        .modelContainer(for: Objective.self, inMemory: true)
}
