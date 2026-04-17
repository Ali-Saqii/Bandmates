//
//  validations.swift
//  Bandmates
//
//  Created by Mac mini on 13/04/2026.
//

import Foundation
import Combine

class Validations {
    
    static let shared = Validations()
    
    func isValidSignUp(
        userName: String,
        email: String,
        password: String,
        confirmPassword: String
    ) -> Bool {
        
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedUserName.isEmpty else { return false }
        
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        guard NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: trimmedEmail) else { return false }
        
        guard password.count >= 7 else { return false }
        guard password.rangeOfCharacter(from: .decimalDigits) != nil else { return false }
        
        let symbols = CharacterSet.punctuationCharacters.union(.symbols)
        guard password.rangeOfCharacter(from: symbols) != nil else { return false }
        if password != confirmPassword {return false} 
        return true
    }
    
    func isValidLogin(name:String,password:String) -> Bool {
        if name.isEmpty || password.isEmpty { return false}
        return true
    }
}
