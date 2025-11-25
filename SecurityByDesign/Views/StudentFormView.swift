import SwiftUI
import OSLog

struct StudentFormView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: StudentViewModel
    
    @State private var firstName: String
    @State private var lastName: String
    @State private var pesel: String
    @State private var email: String
    @State private var address: String
    @State private var city: String
    @State private var postalCode: String
    @State private var phoneNumber: String
    @State private var dateOfBirth: Date
    
    private let student: Student?
    private var isEditing: Bool { student != nil }
    
    init(student: Student? = nil) {
        self.student = student
        _firstName = State(initialValue: student?.firstName ?? "")
        _lastName = State(initialValue: student?.lastName ?? "")
        _pesel = State(initialValue: student?.pesel ?? "")
        _email = State(initialValue: student?.email ?? "")
        _address = State(initialValue: student?.address ?? "")
        _city = State(initialValue: student?.city ?? "")
        _postalCode = State(initialValue: student?.postalCode ?? "")
        _phoneNumber = State(initialValue: student?.phoneNumber ?? "")
        _dateOfBirth = State(initialValue: student?.dateOfBirth ?? Date())
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("PESEL", text: $pesel)
                        .keyboardType(.numberPad)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                }
                
                Section("Contact Information") {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
                
                Section("Address") {
                    TextField("Street Address", text: $address)
                    TextField("City", text: $city)
                    TextField("Postal Code", text: $postalCode)
                }
            }
            .navigationTitle(isEditing ? "Edit Student" : "Add Student")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveStudent()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !pesel.isEmpty && !email.isEmpty
    }
    
    private func saveStudent() {
        AppLogger.student.info("Attempting to save student form")
        AppLogger.student.info("Form data - Name: \(DataMasking.maskFullName(firstName: firstName, lastName: lastName)), PESEL: \(DataMasking.maskPESEL(pesel))")
        AppLogger.student.info("Email: \(DataMasking.maskEmail(email)), Phone: \(DataMasking.maskPhoneNumber(phoneNumber))")
        AppLogger.student.info("Address: \(DataMasking.maskAddress(address)), \(DataMasking.maskCity(city)), \(DataMasking.maskPostalCode(postalCode))")
        
        if let student {
            let updatedStudent = Student(
                id: student.id,
                firstName: firstName,
                lastName: lastName,
                pesel: pesel,
                email: email,
                address: address,
                city: city,
                postalCode: postalCode,
                phoneNumber: phoneNumber,
                dateOfBirth: dateOfBirth
            )
            viewModel.updateStudent(updatedStudent)
        } else {
            let newStudent = Student(
                firstName: firstName,
                lastName: lastName,
                pesel: pesel,
                email: email,
                address: address,
                city: city,
                postalCode: postalCode,
                phoneNumber: phoneNumber,
                dateOfBirth: dateOfBirth
            )
            viewModel.addStudent(newStudent)
        }
        
        dismiss()
    }
}