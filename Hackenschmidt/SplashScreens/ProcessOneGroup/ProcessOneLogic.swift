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
    
    func checkEmail(email: String) -> Bool{
        return email.isEmpty
    }
    
    func checkPassword(password: String) -> Bool{
        return password.isEmpty;
    }
    
    func checkAll(username: String, email: String, password: String) -> Bool{
        if(username.isEmpty){
            return true
        }
        
        if(email.isEmpty){
            return true
        }
        
        if(password.isEmpty){
            return true
        }
        
        return false
    }
}
