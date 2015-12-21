//
//  Crack.swift
//  Crack
//
//  Created by Swizzlr on 9/2/14.
//  Copyright (c) 2014 swizzlr. All rights reserved.
//

/**
    Crack is to Rack as Underwood is to Sinatra.
*/
public protocol CrackApp {
    /**
        This method will be called by the HTTP server for the app to process the request.
        :param: request The request.
    */
    func call(request: HTTPRequest) -> ()
}

/**
    HTTP methods, typesafe!
*/
public enum HTTPMethod: String, Equatable {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case HEAD = "HEAD"
    case DELETE = "DELETE"
}

/**
    A value structure defining an HTTPRequest.
*/
public struct HTTPRequest: Printable, DebugPrintable {
    public let body: String
    public let headers: Dictionary<String, String>
    public let path: String
    public let method: HTTPMethod

    // rdar://18187834 Swift Struct and Class Members
    // Should Inherit Their Containing Class/Struct's Access Visibility
    public init(body: String, headers: Dictionary<String, String>, path: String, method: HTTPMethod) {
        self.body = body
        self.headers = headers
        self.path = path
        self.method = method
    }

    public var description: String {
        return "\(method.rawValue) \(path) with headers\n\(headers)\nand body\n\(body)"
    }
    public var debugDescription: String {
        return description
    }
}