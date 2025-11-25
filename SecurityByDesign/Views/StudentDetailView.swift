import SwiftUI
import OSLog

struct StudentDetailView: View {
    let student: Student
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: StudentViewModel
    @State private var showEditSheet = false
    
    var body: some View {
        List {
            Section("Personal Information") {
                DetailRow(label: "First Name", value: student.firstName)
                DetailRow(label: "Last Name", value: student.lastName)
                DetailRow(label: "PESEL", value: student.pesel)
                DetailRow(label: "Date of Birth", value: student.dateOfBirth.formatted(date: .long, time: .omitted))
            }
            
            Section("Contact Information") {
                DetailRow(label: "Email", value: student.email)
                DetailRow(label: "Phone", value: student.phoneNumber)
            }
            
            Section("Address") {
                DetailRow(label: "Street", value: student.address)
                DetailRow(label: "City", value: student.city)
                DetailRow(label: "Postal Code", value: student.postalCode)
            }
        }
        .navigationTitle("Student Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    AppLogger.student.info("Editing student: \(DataMasking.maskFullName(firstName: student.firstName, lastName: student.lastName)), PESEL: \(DataMasking.maskPESEL(student.pesel))")
                    showEditSheet = true
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    AppLogger.student.warning("Delete button pressed for student PESEL: \(DataMasking.maskPESEL(student.pesel))")
                    viewModel.deleteStudent(student)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            StudentFormView(student: student)
        }
        .onAppear {
            AppLogger.student.info("Viewing student details - Name: \(DataMasking.maskFullName(firstName: student.firstName, lastName: student.lastName))")
            AppLogger.student.info("PESEL: \(DataMasking.maskPESEL(student.pesel)), Address: \(DataMasking.maskAddress(student.address))")
        }
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
    }
}