import OSLog

struct AppLogger {
    static let student = Logger(subsystem: "com.securitybydesign.app", category: "Student")
    static let network = Logger(subsystem: "com.securitybydesign.app", category: "Network")
    static let database = Logger(subsystem: "com.securitybydesign.app", category: "Database")
}