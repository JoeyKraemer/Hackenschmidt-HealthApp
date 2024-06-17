//
//  ProcessOneLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 08.06.2024.
//

import Foundation

class ProcessOneChecker {
    func checkUsername(username: String) -> Bool {
        username.isEmpty
    }

    func checkEmail(email: String) -> Bool {
        email.isEmpty
    }

    func checkPassword(password: String) -> Bool {
        password.isEmpty
    }

    func checkAge(age: Int) -> Bool {
        age <= 0
    }

    func checkAll(username: String, email: String, password: String, age: Int) -> Bool {
        if username.isEmpty {
            return true
        }

        if age <= 0 {
            return true
        }

        if email.isEmpty {
            return true
        }

        if password.isEmpty {
            return true
        }

        return false
    }
}
