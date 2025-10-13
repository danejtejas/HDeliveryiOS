import Foundation



enum ValidationError: LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case empty(field: String)
    case invalidEmail
    case invalidPhone
    case invalidAccountNumber
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .empty(let field): return "\(field) cannot be empty."
        case .invalidEmail: return "Invalid email address."
        case .invalidPhone: return "Invalid phone number."
        case .invalidAccountNumber: return "Invalid bank account number."
        case .custom(let message): return message
        }
    }
}






struct Validator {
    static func isEmpty(_ value: String?) -> Bool {
        (value ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    static func validateEmail(_ email: String?) -> Bool {
        guard let email = email, !email.isEmpty else { return false }
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    static func validatePhone(_ phone: String?) -> Bool {
        guard let phone = phone, !phone.isEmpty else { return false }
        let regex = #"^[0-9]{10}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phone)
    }

    static func validateAccount(_ account: String?) -> Bool {
        guard let account = account else { return false }
        return account.count >= 6
    }

    static func validatePostCode(_ code: String?) -> Bool {
        guard let code = code else { return false }
        let regex = #"^[0-9]{4,6}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: code)
    }
}




protocol FormValidatable {
    func validate() throws
}


protocol ValidationRule {
    func validate(_ value: String?) -> ValidationError?
}

struct RequiredRule: ValidationRule {
    var fieldName: String
    
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .empty(field: fieldName)
        }
        return nil
    }
}

struct EmailRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value, Validator.validateEmail(value) else {
            return .invalidEmail
        }
        return nil
    }
}

struct PhoneRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value, Validator.validatePhone(value) else {
            return .invalidPhone
        }
        return nil
    }
}

struct AccountRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value, Validator.validateAccount(value) else {
            return .invalidAccountNumber
        }
        return nil
    }
}

struct PasswordRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value, value.count >= 6 else {
            return .custom(message: "Password must be at least 6 characters.")
        }
        return nil
    }
}




final class ValidationManager {
    static let shared = ValidationManager()
    private init() {}
    
    /// Validates a dictionary of fields and associated rules.
    func validate(fields: [String: (value: String?, rules: [ValidationRule])]) throws {
        for (key, data) in fields {
            for rule in data.rules {
                if let error = rule.validate(data.value) {
                    throw error
                }
            }
        }
    }
}
