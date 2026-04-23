//
//  subscriptionService.swift
//  Bandmates
//
//  Created by Mac mini on 22/04/2026.
//

import Foundation
import Combine


class SubscriptionService {

    private let baseURL = "http://localhost:3000/user"
    private var token: String {
        UserDefaults.standard.string(forKey: "auth_token") ?? ""
    }
    private var authHeader: [String: String] {
        ["Authorization": "Bearer \(token)"]
    }

    // ── GET Plans ──────────────────────────────────────────────────────────────
    func getPlans() -> AnyPublisher<SubscriptionPlanResponse, Error> {
        guard let url = URL(string: "\(baseURL)/plans") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        authHeader.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        return NetworkLayer.download(request: request)
            .decode(type: SubscriptionPlanResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }

    // ── SELECT Plan ────────────────────────────────────────────────────────────
    func selectPlan(plan: String) -> AnyPublisher<SelectPlanResponse, Error> {
        guard let url = URL(string: "\(baseURL)/select/plan") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let body = ["plan": plan]

        do {
            let request = try NetworkLayer.buildRequest(
                url     : url,
                method  : "POST",
                body    : body,
                headers : authHeader
            )
            return NetworkLayer.download(request: request)
                .decode(type: SelectPlanResponse.self, decoder: NetworkLayer.decoder)
                .eraseToAnyPublisher()
        } catch {
            print("Error: \(error)")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    // ── CANCEL Plan ────────────────────────────────────────────────────────────
    func cancelPlan() -> AnyPublisher<CancelPlanResponse, Error> {
        guard let url = URL(string: "\(baseURL)/cancel/plan") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        authHeader.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        return NetworkLayer.download(request: request)
            .decode(type: CancelPlanResponse.self, decoder: NetworkLayer.decoder)
            .eraseToAnyPublisher()
    }
}
