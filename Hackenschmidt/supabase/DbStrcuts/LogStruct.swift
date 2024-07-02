//
//  LogStruct.swift
//  Hackenschmidt
//
//  Created by Joey Krämer on 21.06.24.
//

// this struct is a representative class in database. We use supabase and it forced us to use snake_case instead of camelCase.
import Foundation

struct Log: Codable {
    var log_id: Int
    var log_date: String
    var user_id: UUID?
}
