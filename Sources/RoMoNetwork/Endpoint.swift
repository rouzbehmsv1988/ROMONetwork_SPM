//
//  Endpoint.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation
import Combine

// you can input your baseURL and API Key here inorder to have access to the API service you want
public struct ROMOEndpoint {
    public init(baseURL: URL, headers: [String: String]? = nil, params: [[String:String]]? = [], method: MethodTypes, path: String? = nil) {
        self.baseURL = baseURL
        self.headers = headers
        self.method = method
        self.params = params
        self.path = path
    }
    public enum MethodTypes: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "Delete"
    }
    private var baseURL: URL
    private var headers: [String: String]?
    private var params: [[String:String]]?
    private var method: MethodTypes
    private var path: String?
    public var request: URLRequest {
        guard let path = self.path, var component = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        else {
            fatalError("Could not create component")
        }
        component.queryItems = queryItems
        
        guard let url = component.url else {fatalError("couldnt find url")}
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
    private var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        guard let params = self.params else { return items}
        for param in params {
            if let objectKey = param.keys.first, let objectValue = param.values.first {
                items.append(URLQueryItem(name: objectKey, value: objectValue))
            }
        }
       
        return items
    }

    
    
    
}

