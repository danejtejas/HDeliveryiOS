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
    
    static func isValidCarPlate(_ plate: String) -> Bool {
        let regex = #"^[A-Za-z0-9]{4,10}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: plate)
    }
    
    static func isValidIdentity(_ id: String) -> Bool {
        let regex = #"^[0-9]{4,6}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: id)
    }
    
    static func isValidYear(_ year: String) -> Bool {
        let regex = #"^(19|20)\d{2}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: year)
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
    
    let fieldName: String
    
    init(fieldName: String = "Password") {
        self.fieldName = fieldName
    }
    
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value, value.count >= 6 else {
            return .custom(message: "\(fieldName) must be at least 6 characters.")
        }
        return nil
    }
}
struct PostCodedRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value,  Validator.validatePostCode(value)else {
            return .custom(message: "Please enter a valid postcode.")
        }
        return nil
    }
}


struct YearRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value,  Validator.isValidYear(value)else {
            return .custom(message: "Please enter a valid year.")
        }
        return nil
    }
}

struct CarePlateRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value,  Validator.isValidCarPlate(value)else {
            return .custom(message: "Please enter a valid care plate no.")
        }
        return nil
    }
}

struct IdentityRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let value = value,  Validator.isValidIdentity(value)else {
            return .custom(message: "Please enter a valid Identity.")
        }
        return nil
    }
}

struct ConfirmPasswordRule: ValidationRule {
    let newPassword: String
    let fieldName: String

    func validate(_ value: String?) -> ValidationError? {
        guard let confirmPassword = value else {
            return .custom(message: "\(fieldName) is required.")
        }
        guard confirmPassword == newPassword else {
            return .custom(message: "New password and \(fieldName.lowercased()) do not match.")
        }
        return nil
    }
}


struct PickupAddressRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let address = value,
              !address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .custom(message: "Please enter a valid pickup address.")
        }
        return nil
    }
}


struct DropAddressRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let address = value,
              !address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .custom(message: "Please enter a valid drop address.")
        }
        return nil
    }
}



struct SelectedItemRule: ValidationRule {
    func validate(_ value: String?) -> ValidationError? {
        guard let items = value?.trimmingCharacters(in: .whitespacesAndNewlines),
              !items.isEmpty else {
            return .custom(message: "Please select at least one item for pickup.")
        }
        return nil
    }
}



//
//struct RegexRule: ValidationRule {
//    let pattern: String
//    let message: String
//    func validate(_ value: String) -> String? {
//        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
//        return predicate.evaluate(with: value) ? nil : message
//    }
//}
//
//struct MinLengthRule: ValidationRule {
//    func validate(_ value: String?) -> ValidationError? {
//        <#code#>
//    }
//    
//    let fieldName: String
//    let minLength: Int
//    func validate(_ value: String?) -> String? {
//        if value?.count < minLength {
//            return "\(fieldName) must be at least \(minLength) characters."
//        }
//        return nil
//    }
//}
//
//struct MaxLengthRule: ValidationRule {
//    let fieldName: String
//    let maxLength: Int
//    func validate(_ value: String) -> String? {
//        if value.count > maxLength {
//            return "\(fieldName) must not exceed \(maxLength) characters."
//        }
//        return nil
//    }
//}





final class ValidationManager {
    static let shared = ValidationManager()
    private init() {}
    
    /// Validates a dictionary of fields and associated rules.
    func validate(fields: [String: (value: String?, rules: [ValidationRule])]) throws {
        for (key, data) in fields {
            for rule in data.rules {
                if let error = rule.validate(data.value) {
                    throw error
                    break
                    
                }
            }
        }
    }
    
    
    
    func validate(fields: [String: (value: String?, rules: [ValidationRule])], fieldOrders : [String] ) throws {
        for field in fieldOrders {
            if let field = fields[field] {
                for rule in field.rules {
                    if let error = rule.validate(field.value) {
                        throw error
                       
                        
                    }
                }
            }
        }
        
       
    }
}
