import Foundation
import Combine

class NetworkLayer {

    // MARK: - Errors
    enum NetworkingError: LocalizedError {
        case badUrlResponse(url: URL)
        case unknown

        var errorDescription: String? {
            switch self {
            case .badUrlResponse(let url):
                return "Bad URL response: \(url)"
            case .unknown:
                return "Unknown error occurred"
            }
        }
    }

    // MARK: - JSON Decoder (GLOBAL FIX HERE 🔥)
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            if let date = formatter.date(from: dateStr) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date format: \(dateStr)"
            )
        }

        return decoder
    }()

    // MARK: - GET Request (URLRequest version)
    static func download(request: URLRequest) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleResponse(output: $0, url: request.url!) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - GET Request (URL version)
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try handleResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Response Validation
    static func handleResponse(
        output: URLSession.DataTaskPublisher.Output,
        url: URL
    ) throws -> Data {

        guard let response = output.response as? HTTPURLResponse,
              200...299 ~= response.statusCode else {
            throw NetworkingError.badUrlResponse(url: url)
        }

        return output.data
    }

    // MARK: - Completion Helper
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("❌ Error:", error.localizedDescription)
        }
    }
    
    // post
    static func post <T: Encodable> (
        url: URL,
        body: T,
        headers: [String:String] = [:]
    ) -> AnyPublisher <Data ,Error> {
        do {
            let request = try buildRequest(url: url,
                                           method: "POST",
                                           body: body,
                                           headers: headers
            )
            
            return download(request: request)
        }catch {
            print("\(error)")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    // put
    static func put<T: Encodable>(
          url: URL,
          body: T,
          headers: [String: String] = [:]
      ) -> AnyPublisher<Data, Error> {
          do {
              let request = try buildRequest(
                  url: url,
                  method: "PUT",
                  body: body,
                  headers: headers
              )
              return download(request: request)
          } catch {
              print("\(error)")

              return Fail(error: error).eraseToAnyPublisher()
          }
      }
    //patch
    static func patch<T: Encodable>(
        url: URL,
        body: T,
        headers: [String: String] = [:]
    ) -> AnyPublisher<Data, Error> {
        do {
            let request = try buildRequest(
                url: url,
                method: "PATCH",
                body: body,
                headers: headers
            )
            return download(request: request)
        } catch {
            print("\(error)")

            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    // delete
    static func delete(
         url: URL,
         headers: [String: String] = [:]
     ) -> AnyPublisher<Data, Error> {
         var request = URLRequest(url: url)
         request.httpMethod = "DELETE"
         headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
         return download(request: request)
     }
    
    // request builder
    private static func buildRequest<T: Encodable>(
        url: URL,
        method: String,
        body: T,
        headers: [String: String]
    ) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        request.httpBody = try JSONEncoder().encode(body)
        return request
    }
}


