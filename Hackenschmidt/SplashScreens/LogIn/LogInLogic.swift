//
//  LogInLogic.swift
//  Hackenschmidt
//
//  Created by Богдан Закусило on 12.06.2024.
//

import Foundation


class LogInChecker{
    func checkPassword(password: String) -> Bool{
        return password.isEmpty
    }
    
    func checkEmail(email : String) -> Bool{
        return email.isEmpty
    }
    
    func checkAll(password: String, email: String) -> Bool{
        if(password.isEmpty){
            return true
        }
        
        if(email.isEmpty){
            return true
        }
        
        return false
    }
}
