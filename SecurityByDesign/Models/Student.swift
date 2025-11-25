import Foundation

struct Student: Identifiable, Codable {
    let id: UUID
    var firstName: String
    var lastName: String
    var pesel: String
    var email: String
    var address: String
    var city: String
    var postalCode: String
    var phoneNumber: String
    var dateOfBirth: Date
    
    init(
        id: UUID = UUID(),
        firstName: String = "",
        lastName: String = "",
        pesel: String = "",
        email: String = "",
        address: String = "",
        city: String = "",
        postalCode: String = "",
        phoneNumber: String = "",
        dateOfBirth: Date = Date()
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.pesel = pesel
        self.email = email
        self.address = address
        self.city = city
        self.postalCode = postalCode
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
    }
}