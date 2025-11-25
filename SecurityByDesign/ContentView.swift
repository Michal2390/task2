//
//  ContentView.swift
//  SecurityByDesign
//
//  Created by Michal Fereniec on 25/11/2025.
//

import SwiftUI
import OSLog

struct ContentView: View {
    @StateObject private var viewModel = StudentViewModel()
    @State private var showAddSheet = false
    @State private var searchText = ""
    
    var filteredStudents: [Student] {
        if searchText.isEmpty {
            return viewModel.students
        }
        return viewModel.students.filter { student in
            student.firstName.localizedCaseInsensitiveContains(searchText) ||
            student.lastName.localizedCaseInsensitiveContains(searchText) ||
            student.pesel.contains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredStudents) { student in
                    NavigationLink {
                        StudentDetailView(student: student)
                            .environmentObject(viewModel)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(student.firstName) \(student.lastName)")
                                .font(.headline)
                            Text("PESEL: \(student.pesel)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { oldValue, newValue in
                if !newValue.isEmpty {
                    viewModel.searchStudents(query: newValue)
                }
            }
            .navigationTitle("Students")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AppLogger.student.info("Add new student button pressed")
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                StudentFormView()
                    .environmentObject(viewModel)
            }
            .onAppear {
                AppLogger.student.info("ContentView appeared. Total students: \(viewModel.students.count)")
            }
        }
    }
}

#Preview {
    ContentView()
}