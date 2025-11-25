# Security By Design - iOS Swift Implementation

This is an iOS implementation of the Security By Design tasks, converted from the original Java/Python examples.

## Project Overview

This is a student management application built with SwiftUI that intentionally contains security vulnerabilities for educational purposes. The app allows users to:
- View a list of students
- Add new students with personal information (PESEL, address, etc.)
- Edit existing student records
- Search for students
- Delete student records

## Requirements

1. Xcode 15.0 or later
2. macOS with iOS Simulator
3. Basic understanding of Swift and iOS development

## Setup

1. Open `SecurityByDesign.xcodeproj` in Xcode
2. Select a simulator (iPhone 15 Pro recommended)
3. Press Cmd+R to build and run the application

## Tasks

### Task 1 - Verification of Sensitive Data Leakage in Logs

**Goal:** Test the application to verify if logs contain sensitive data that should not be present in application logs.

#### Instructions:

1. **Run the Application**
   - Open the project in Xcode
   - Run the app in the simulator (Cmd+R)
   - Open the Console in Xcode (Cmd+Shift+C) or use the Debug Console

2. **Interact with the Application**
   - Add a new student with sample data
   - Edit an existing student
   - Search for students using the search bar
   - View student details
   - Delete a student

3. **Verify Logs**
   - In Xcode's Console, filter for logs from subsystem: `com.securitybydesign.app`
   - Look for sensitive data such as:
     - **PESEL numbers** (Polish national identification number)
     - **Full addresses** (street, city, postal code)
     - **Personal information** that should not be logged

4. **Identify the Issues**
   - Find where sensitive data is being logged
   - Document which files and functions are logging this data

5. **Propose a Fix**
   - Create a solution that **masks sensitive data** in logs
   - Instead of logging `PESEL: 92071234567`, it should log `PESEL: ***********`
   - Address should be masked as `Address: ***, *** ***`
   - **Do not change the log format** - only mask the sensitive values

#### Expected Findings:

You should find sensitive data logged in:
- `StudentViewModel.swift` - when adding, updating, and searching students
- `StudentDetailView.swift` - when viewing student details
- `StudentFormView.swift` - when saving student data
- `APIService.swift` - when syncing student data

---

### Task 2 - Verification of Hardcoded Secrets

**Goal:** Verify if there are secrets and/or passwords hardcoded in the source code.

#### Instructions:

1. **Manual Code Review**
   - Search through the project files for hardcoded credentials
   - Look for:
     - API keys
     - API secrets
     - Passwords
     - Database connection strings
     - Authentication tokens

2. **Use Automated Tools**
   
   You can use `gitleaks` to scan for secrets:


   <img width="335" height="468" alt="image" src="https://github.com/user-attachments/assets/572aea59-fd94-4829-b22f-9ee8a70fa75e" />

   ## 🎯 Best Practices Applied

### 1. Defense in Depth
- ✅ Masking at log point
- ✅ No PII in analytics
- ✅ Encrypted logs at rest (recommended)
- ✅ Secure log transmission

### 2. Principle of Least Privilege
- ✅ Logs contain minimum necessary info
- ✅ Debug data available without exposing PII
- ✅ Audit trail maintained

### 3. Privacy by Design
- ✅ PII protection built into logging
- ✅ Default to secure
- ✅ Transparent data handling

### 4. Maintainability
- ✅ Centralized masking logic
- ✅ Easy to update policies
- ✅ Well-documented code
- ✅ Unit tested

### 5. Compliance
- ✅ GDPR Article 25 (Data protection by design)
- ✅ GDPR Article 32 (Security of processing)
- ✅ RODO compliance
- ✅ Industry best practices

