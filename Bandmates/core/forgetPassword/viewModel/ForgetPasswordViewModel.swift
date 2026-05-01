//
//  ForgetPasswordViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 28/04/2026.
//

import Foundation
import Combine

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isLoading: Bool = false
    @Published var successMessage: String? = nil
    @Published var errorMessage: String? = nil
    @Published var isEmailSent: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func sendResetLink() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            return
        }
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "http://localhost:3000/user/auth/forgot-password") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let body = ["email": email.lowercased()]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] data, response in
                self?.isLoading = false

                do {
                    let decoded = try JSONDecoder().decode(ForgotPasswordResponse.self, from: data)
                    self?.isEmailSent = true
                    print("✅ Success:", decoded.message)
                    print("🔑 Token:", decoded.token)
                } catch {
                    self?.errorMessage = "Something went wrong"
                }
            }
            .store(in: &cancellables)
    }
}

struct ForgotPasswordResponse: Codable {
    let message: String
    let token: String
}
