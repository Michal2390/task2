import Foundation

/// Utility for masking sensitive data in logs
struct DataMasking {
    
    /// Masks PESEL number by replacing all digits with asterisks
    /// - Parameter pesel: PESEL number to mask
    /// - Returns: Masked string with asterisks
    static func maskPESEL(_ pesel: String) -> String {
        guard !pesel.isEmpty else { return "" }
        return String(repeating: "*", count: pesel.count)
    }
    
    /// Masks street address
    /// - Parameter address: Street address to mask
    /// - Returns: Masked address as "***"
    static func maskAddress(_ address: String) -> String {
        guard !address.isEmpty else { return "" }
        return "***"
    }
    
    /// Masks city name
    /// - Parameter city: City name to mask
    /// - Returns: Masked city as "***"
    static func maskCity(_ city: String) -> String {
        guard !city.isEmpty else { return "" }
        return "***"
    }
    
    /// Masks postal code
    /// - Parameter postalCode: Postal code to mask
    /// - Returns: Masked postal code as "***"
    static func maskPostalCode(_ postalCode: String) -> String {
        guard !postalCode.isEmpty else { return "" }
        return "***"
    }
    
    /// Masks email address, keeping first 2 characters and domain
    /// Example: john.doe@example.com -> jo********@example.com
    /// - Parameter email: Email address to mask
    /// - Returns: Partially masked email
    static func maskEmail(_ email: String) -> String {
        guard let atIndex = email.firstIndex(of: "@") else {
            return String(repeating: "*", count: email.count)
        }
        
        let username = email[..<atIndex]
        let domain = email[atIndex...]
        
        if username.count <= 2 {
            return "\(String(repeating: "*", count: username.count))\(domain)"
        }
        
        return "\(username.prefix(2))\(String(repeating: "*", count: username.count - 2))\(domain)"
    }
    
    /// Masks phone number, keeping last 4 digits
    /// Example: +48 123 456 789 -> ********** 789
    /// - Parameter phone: Phone number to mask
    /// - Returns: Partially masked phone number
    static func maskPhoneNumber(_ phone: String) -> String {
        guard phone.count > 4 else {
            return String(repeating: "*", count: phone.count)
        }
        
        let visibleCount = 4
        let maskedCount = phone.count - visibleCount
        return String(repeating: "*", count: maskedCount) + phone.suffix(visibleCount)
    }
    
    /// Masks full name, showing only first letter of each name
    /// Example: Jan Kowalski -> J. K.
    /// - Parameters:
    ///   - firstName: First name
    ///   - lastName: Last name
    /// - Returns: Masked name with initials
    static func maskFullName(firstName: String, lastName: String) -> String {
        let firstInitial = firstName.prefix(1)
        let lastInitial = lastName.prefix(1)
        return "\(firstInitial). \(lastInitial)."
    }
    
    /// Masks API key or secret, showing only first 4 and last 4 characters
    /// Example: sk_live_1234567890abcdef -> sk_l************cdef
    /// - Parameter secret: Secret/API key to mask
    /// - Returns: Partially masked secret
    static func maskSecret(_ secret: String) -> String {
        guard secret.count > 8 else {
            return String(repeating: "*", count: secret.count)
        }
        
        let prefix = secret.prefix(4)
        let suffix = secret.suffix(4)
        let maskedMiddle = String(repeating: "*", count: secret.count - 8)
        return "\(prefix)\(maskedMiddle)\(suffix)"
    }
    
    /// Masks password completely
    /// - Parameter password: Password to mask
    /// - Returns: Completely masked password
    static func maskPassword(_ password: String) -> String {
        guard !password.isEmpty else { return "" }
        return String(repeating: "*", count: min(password.count, 10))
    }
}