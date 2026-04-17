//
//  authService.swift
//  Bandmates
//
//  Created by Mac mini on 13/04/2026.
//

import Foundation
import Combine

class AuthService {
    
    static let shared = AuthService()
    
    private let baseUrl = "http://localhost:3000"
    
    func signUp(username:String,email:String,password: String,confirmPassword:String,avatar: Data? = nil ) -> AnyPublisher<AuthResponse, Error> {
        let url = URL(string: "\(baseUrl)/user/signUp")
        guard let url = url else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        let fields: [String: String] = [
                    "username":         username,
                    "email":            email,
                    "password":         password,
                    "confirm_password": confirmPassword,
                    "terms":            "true"
                ]
        fields.forEach { key, value in
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        if let imageData = avatar {
                  body.append("--\(boundary)\r\n".data(using: .utf8)!)
                  body.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"avatar.jpg\"\r\n".data(using: .utf8)!)
                  body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                  body.append(imageData)
                  body.append("\r\n".data(using: .utf8)!)
              }

              body.append("--\(boundary)--\r\n".data(using: .utf8)!)
              request.httpBody = body
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                        print("🔴 Raw Response: \(String(data: data, encoding: .utf8) ?? "nil")")
                    })
            .decode(type: AuthResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
    // LOGIN 
 
    func login(
        email:    String,
        password: String
    ) -> AnyPublisher<AuthResponse, Error> {
 
        let url = URL(string: "\(baseUrl)/user/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let body: [String: String] = [
            "email":    email,
            "password": password
        ]
 
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
 
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                        print("🔴 Raw Response: \(String(data: data, encoding: .utf8) ?? "nil")")
                    })
            .decode(type: AuthResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
