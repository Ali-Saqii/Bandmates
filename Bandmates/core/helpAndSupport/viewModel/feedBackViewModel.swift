//
//  feedBackViewModel.swift
//  Bandmates
//
//  Created by Mac mini on 30/04/2026.
//

import Foundation
import Combine

class HelpSupportViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var contactNumber: String = ""
    @Published var email: String = ""
    @Published var feedback: String = ""
    @Published var isLoading: Bool = false
    @Published var successMessage: String? = nil
    @Published var errorMessage: String? = nil
    @Published var isFeeBackSent: Bool = false

    private var cancellables = Set<AnyCancellable>()

    private var token: String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }

    func sendFeedback() {
        guard !name.isEmpty, !contactNumber.isEmpty, !email.isEmpty, !feedback.isEmpty else {
            errorMessage = "All fields are required"
            return
        }

        isLoading = true
        errorMessage = nil
        successMessage = nil

        guard let url = URL(string: "http://localhost:3000/user/feedback") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body: [String: String] = [
            "name": name,
            "contactNumber": contactNumber,
            "email": email,
            "feedback": feedback
        ]
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
                print("🔍 RAW:", String(data: data, encoding: .utf8) ?? "nil")

                do {
                    let decoded = try JSONDecoder().decode(FeedbackResponse.self, from: data)
                    if decoded.success {
                        self?.successMessage = "Feedback sent successfully!"
                        self?.clearFields()
                        self?.isFeeBackSent = true
                    } else {
                        self?.errorMessage = decoded.message
                    }
                } catch {
                    self?.errorMessage = "Something went wrong"
                }
            }
            .store(in: &cancellables)
    }

    private func clearFields() {
        name = ""
        contactNumber = ""
        email = ""
        feedback = ""
    }
}

struct FeedbackResponse: Codable {
    let success: Bool
    let message: String
}
