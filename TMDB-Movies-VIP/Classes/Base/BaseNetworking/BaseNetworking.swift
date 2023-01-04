//
//  BaseNetworking.swift
//  
//
//  Created by Bradley Hoang on 28/12/2022.
//

import Foundation
import Alamofire

class BaseNetworking {
    func fetchData<M: Decodable>(configuration: Configuration,
                                 responseType: M.Type,
                                 completion: @escaping (Result<M, ServiceError>) -> Void) {
        let parameters = generateParams(task: configuration.task)
        let url = configuration.baseURL + configuration.path.escape()
        guard var components = URLComponents(string: url) else {
            completion(.failure(.urlError))
            return
        }
        
        if configuration.method == HTTPMethod.get {
            components.queryItems = parameters.0.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        guard let url = components.url else {
            completion(.failure(.urlError))
            return
        }
        
        // Create request
        let request = self.generateRequest(url: url,
                                           method: configuration.method.rawValue,
                                           headers: configuration.headers)
        
        if configuration.method == HTTPMethod.post {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters.0, options: [])
            request.httpBody = jsonData
        }
        
        Logger.log(request: request)
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            Logger.log(data: data, response: response as? HTTPURLResponse, error: error)
            
            DispatchQueue.main.async {
                guard error == nil else {
                    let errorMessage = error?.localizedDescription ?? "Server Error"
                    completion(.failure(.init(issueCode: .initValue(value: errorMessage))))
                    return
                }
                guard let existData = data, let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(ServiceError.notFoundData))
                    return
                }
                
                guard self.isSuccess(httpResponse.statusCode) else {
                    /// `Refresh token logic`
                    /// We can handle refresh token logic here
                    /// Because this is a test project, so I will not handle this
                    
                    completion(.failure(.notFoundData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseObj = try decoder.decode(M.self, from: existData)
                    completion(.success(responseObj))
                } catch {
                    print("\n----- Parse Model Error: \n", error)
                    print("\n----- End:")
                    completion(.failure(.parseError))
                }
            }
        }
        
        dataTask.resume()
    }
}

// MARK: - Private

private extension BaseNetworking {
    func generateRequest(url: URL, method: String, headers: [String: String]?) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = nil
        
        for (key, value) in headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    func generateParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case let .requestParameters(parameters, encoding):
            return (parameters, encoding)
        }
    }
    
    func isSuccess(_ code: Int) -> Bool {
        switch code {
        case 200...304:
            return true
        default:
            return false
        }
    }
}
