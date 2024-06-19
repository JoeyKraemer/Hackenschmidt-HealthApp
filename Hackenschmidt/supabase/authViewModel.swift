//
//  authViewModel.swift
//  Hackenschmidt
//
//  Created by paul on 17/06/2024.
//

import Foundation
import KeychainAccess
import Supabase
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var userEmail: String?
    @Published var errorMessage: String?
    @Published var uid: UUID?
    @Published var isLoading: Bool = false

    let client: SupabaseClient
    let keychain: Keychain
    
    static let shared = AuthViewModel()

    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://ggelsjpzpdreuoxgaxid.supabase.co")!,
            supabaseKey:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdnZWxzanB6cGRyZXVveGdheGlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ3MjgxMzcsImV4cCI6MjAzMDMwNDEzN30.X4BYTMMVwqSCExMOb-7UeqDciaQBmZxNfhiInR-S178"
        )
        keychain = Keychain(service: "com.hackenschmidt.Hackenschmidt")
        Task {
            await restoreSession()
        }
        
        Task{
            print("I am initialised")
        }
    }

    func signIn(email: String, password: String) async {
        isLoading = true
        do {
            let session = try await client.auth.signIn(email: email, password: password)
            saveSession(session)
            DispatchQueue.main.async {
                self.userEmail = session.user.email
                self.uid = session.user.id
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
        
        print("Succes")
    }

    func saveSession(_ session: Session) {
        keychain["access_token"] = session.accessToken
        keychain["refresh_token"] = session.refreshToken
    }

    func restoreSession() async {
        if let accessToken = keychain["access_token"],
           let refreshToken = keychain["refresh_token"]
        {
            do {
                let session = try await client.auth.setSession(
                    accessToken: accessToken, refreshToken: refreshToken
                )
                DispatchQueue.main.async {
                    self.userEmail = session.user.email
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func isLoggedIn() -> Bool {
        if let _ = keychain["access_token"], let _ = keychain["refresh_token"] {
            return true
        } else {
            return false
        }
    }
}
