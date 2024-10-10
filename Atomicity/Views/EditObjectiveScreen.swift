//
//  EditObjectiveScreen.swift
//  Atomicity
//
//  Created by Joseph DeWeese on 10/8/24.
//

import SwiftUI
import PhotosUI

struct EditObjectiveScreen: View {
    @Environment(\.dismiss) private var dismiss
    let objective: Objective
    @State private var status: Status
    @State private var rating: Int?
    @State private var title = ""
    @State private var briefDescription = ""
    @State private var synopsis = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast

    @State private var showFocusList = false
//    @State private var selectedBookCover: PhotosPickerItem?
//    @State private var selectedBookCoverData: Data?
    
    init(objective: Objective) {
        self.objective = objective
        _status = State(initialValue: Status(rawValue: objective.status)!)
    }
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    switch status {
                    case .Queue:
                        DatePicker("", selection: $dateAdded, displayedComponents: .date)
                    case .inProgress, .completed:
                        DatePicker("", selection: $dateAdded, in: ...dateStarted, displayedComponents: .date)
                    }
                    
                } label: {
                    Text("Date Added")
                }
                if status == .inProgress || status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if newValue == .Queue {
                    dateStarted = Date.distantPast
                    dateCompleted = Date.distantPast
                } else if newValue == .inProgress && oldValue == .completed {
                    // from completed to inProgress
                    dateCompleted = Date.distantPast
                } else if newValue == .inProgress && oldValue == .Queue {
                    // Book has been started
                    dateStarted = Date.now
                } else if newValue == .completed && oldValue == .Queue {
                    // Forgot to start book
                    dateCompleted = Date.now
                    dateStarted = dateAdded
                } else {
                    // completed
                    dateCompleted = Date.now
                }
            }
            Divider()
            //            HStack {
            //                PhotosPicker(
            //                    selection: //$selectedBookCover,
            //                    matching: .images,
            //                    photoLibrary: .shared()) {
            //                        Group {
            //                            if let selectedBookCoverData,
            //                               let uiImage = UIImage(data: selectedBookCoverData) {
            //                                Image(uiImage: uiImage)
            //                                    .resizable()
            //                                    .scaledToFit()
            //                            } else {
            //                                Image(systemName: "photo")
            //                                    .resizable()
            //                                    .scaledToFit()
            //                                    .tint(.primary)
            //                            }
            //                        }
            //                        .frame(width: 75, height: 100)
            //                        .overlay(alignment: .bottomTrailing) {
            //                            if selectedBookCoverData != nil {
            //                                Button {
            //                                    selectedBookCover = nil
            //                                    selectedBookCoverData = nil
            //                                } label: {
            //                                    Image(systemName: "x.circle.fill")
            //                                        .foregroundStyle(.red)
            //                                }
            //                            }
            //                        }
            //                    }
            VStack {
                LabeledContent {
                    
                } label: {
                    Text("Priority")
                }
                LabeledContent {
                    TextField("", text: $title)
                } label: {
                    Text("Title").foregroundStyle(.secondary)
                }
                LabeledContent {
                    TextField("", text: $briefDescription)
                } label: {
                    Text("Brief Description").foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        Divider()
        Text("Synopsis").foregroundStyle(.secondary)
        TextEditor(text: $synopsis)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
        if objective.focusList != nil {
            ViewThatFits {
                //         GenresStackView(genres: genres)
                ScrollView(.horizontal, showsIndicators: false) {
                    //            GenresStackView(genres: genres)
                }
            }
        }
        HStack {
            Button("Focus Tag", systemImage: "bookmark.fill") {
                showFocusList.toggle()
            }
            .sheet(isPresented: $showFocusList) {
                //  GenresView(book: book)
            }
            NavigationLink {
                ///       QuotesListView(book: book)
            } label: {
                let count = objective.notes?.count ?? 0
                Label("\(count) Notes", systemImage: "quote.opening")
            }
        }
        .buttonStyle(.bordered)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
        .toolbar {
            if changed {
                Button("Update") {
                    objective.status = status.rawValue
                    objective.title = title
                    objective.briefDescription = briefDescription
                    objective.dateAdded = dateAdded
                    objective.dateStarted = dateStarted
                    objective.dateCompleted = dateCompleted
                    
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            title = objective.title
            briefDescription = objective.briefDescription
            
            dateAdded = objective.dateAdded
            dateStarted = objective.dateStarted
            dateCompleted = objective.dateCompleted
            
        }
    }
    
    
    var changed: Bool {
        status != Status(rawValue: objective.status)!
        || title != objective.title
        || briefDescription != objective.briefDescription
        || dateAdded != objective.dateAdded
        || dateStarted != objective.dateStarted
        || dateCompleted != objective.dateCompleted
       
    }
}

