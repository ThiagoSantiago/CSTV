//
//  CSTVMatchesApiRequest.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 21/11/22.
//

import Foundation

protocol CSTVApiRequestProtocol {
    func request<T: Decodable>(with request: CSTVApiSetupProtocol, completion: @escaping (Swift.Result<T, CSTVApiError>) -> Void)
}

final class CSTVApiRequest: CSTVApiRequestProtocol {
    
    func request<T: Decodable>(with request: CSTVApiSetupProtocol, completion: @escaping (Swift.Result<T, CSTVApiError>) -> Void) {
        var  jsonData = NSData()
        
        guard let urlRequest = URL(string: request.endpoint) else {
            DispatchQueue.main.async {
                completion(.failure(.badUrl))
            }
            return
        }
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: request.parameters, options: .prettyPrinted) as NSData
        } catch {
            DispatchQueue.main.async {
                completion(.failure(.brokenData))
            }
        }
        
        var requestData = URLRequest(url: urlRequest)
        requestData.httpMethod = request.method.rawValue
        requestData.allHTTPHeaderFields = request.headers
        if !request.parameters.isEmpty {
            requestData.httpBody = jsonData as Data
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: requestData) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.unknown(error.localizedDescription)))
                }
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.brokenData))
                }
                return
            }
            
            if let returnData = String(data: data, encoding: .utf8) {
                print("=> Request return data: \(returnData)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.unknown("Could not cast to HTTPURLResponse object.")))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(self.handler(statusCode: httpResponse.statusCode, dataResponse: data))
            }
        }
        
        task.resume()
    }
    
    private func handler<T: Decodable>(statusCode: Int, dataResponse: Data) -> Swift.Result<T, CSTVApiError> {
        
        switch statusCode {
        case 200...299:
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseModel = try decoder.decode(T.self, from: dataResponse)
                return .success(responseModel)
            } catch {
                return .failure(.couldNotParseObject)
            }
        case 403:
            return .failure(.authenticationRequired)
            
        case 404:
            return .failure(.couldNotFindHost)
            
        case 500:
            return .failure(.badRequest)
            
        default: return .failure(.unknown("Internal error!"))
        }
    }
}
