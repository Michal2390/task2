import Foundation
import OSLog

@MainActor
class StudentViewModel: ObservableObject {
    @Published var students: [Student] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService = APIService()
    
    init() {
        loadSampleData()
    }
    
    func loadSampleData() {
        students = [
            Student(
                firstName: "Jan",
                lastName: "Kowalski",
                pesel: "92071234567",
                email: "jan.kowalski@example.com",
                address: "ul. Kwiatowa 15/3",
                city: "Warsaw",
                postalCode: "00-001",
                phoneNumber: "+48 123 456 789",
                dateOfBirth: Date()
            ),
            Student(
                firstName: "Anna",
                lastName: "Nowak",
                pesel: "85032198765",
                email: "anna.nowak@example.com",
                address: "ul. Słoneczna 42",
                city: "Krakow",
                postalCode: "30-001",
                phoneNumber: "+48 987 654 321",
                dateOfBirth: Date()
            )
        ]
    }
    
    func addStudent(_ student: Student) {
        AppLogger.student.info("Adding new student")
        AppLogger.student.info("Student details - Name: \(DataMasking.maskFullName(firstName: student.firstName, lastName: student.lastName))")
        AppLogger.student.info("PESEL: \(DataMasking.maskPESEL(student.pesel))")
        AppLogger.student.info("Email: \(DataMasking.maskEmail(student.email))")
        AppLogger.student.info("Address: \(DataMasking.maskAddress(student.address)), \(DataMasking.maskCity(student.city)) \(DataMasking.maskPostalCode(student.postalCode))")
        AppLogger.student.info("Phone: \(DataMasking.maskPhoneNumber(student.phoneNumber))")
        
        students.append(student)
        
        Task {
            await apiService.syncStudent(student)
        }
        
        AppLogger.student.info("Student added successfully with ID: \(student.id)")
    }
    
    func updateStudent(_ student: Student) {
        AppLogger.student.info("Updating student with ID: \(student.id)")
        AppLogger.student.info("Updated PESEL: \(DataMasking.maskPESEL(student.pesel))")
        AppLogger.student.info("Updated address: \(DataMasking.maskAddress(student.address)), \(DataMasking.maskCity(student.city))")
        
        if let index = students.firstIndex(where: { $0.id == student.id }) {
            students[index] = student
            
            Task {
                await apiService.syncStudent(student)
            }
            
            AppLogger.student.info("Student updated successfully")
        }
    }
    
    func deleteStudent(_ student: Student) {
        AppLogger.student.info("Deleting student: \(DataMasking.maskFullName(firstName: student.firstName, lastName: student.lastName))")
        AppLogger.student.info("Deleted student PESEL: \(DataMasking.maskPESEL(student.pesel))")
        
        students.removeAll { $0.id == student.id }
        
        AppLogger.student.info("Student deleted successfully")
    }
    
    func searchStudents(query: String) {
        AppLogger.student.info("Searching for student with query: \(query)")
        
        let results = students.filter { student in
            student.firstName.localizedCaseInsensitiveContains(query) ||
            student.lastName.localizedCaseInsensitiveContains(query) ||
            student.pesel.contains(query) ||
            student.email.localizedCaseInsensitiveContains(query)
        }
        
        AppLogger.student.info("Search completed. Found \(results.count) students")
        
        for student in results {
            AppLogger.student.info("Match found: \(DataMasking.maskFullName(firstName: student.firstName, lastName: student.lastName)) - PESEL: \(DataMasking.maskPESEL(student.pesel))")
        }
    }
}