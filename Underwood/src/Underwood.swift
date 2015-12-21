//
//  Underwood.swift
//  underwood
//
//  Created by Swizzlr on 8/29/14.
//  Copyright (c) 2014 swizzlr. All rights reserved.
//

import Crack

public class 🇺🇸: CrackApp {
    public init() {}
    final var pathToMethodActionMap: Dictionary<String, Dictionary<HTTPMethod, ((request: HTTPRequest) -> ())>> = Dictionary();

    public final func call(request: HTTPRequest) {
        pathToMethodActionMap[request.path]?[request.method]?(request: request)
    }

    func registerActionForPathWithMethod(action: (request: HTTPRequest) -> (), path: String, method: HTTPMethod) {
        if var methodActionMap = pathToMethodActionMap[path] {
            methodActionMap.updateValue(action, forKey: method)
            pathToMethodActionMap[path] = methodActionMap
        } else {
            let newActionMethodMap = [method: action]
            pathToMethodActionMap[path] = newActionMethodMap
        }
    }

    public final func get(path: String, action: (request: HTTPRequest) -> ()) {
        registerActionForPathWithMethod(action, path: path, method: HTTPMethod.GET)
    }
    public final func post(path: String, action: (request: HTTPRequest) -> ()) {
        registerActionForPathWithMethod(action, path: path, method: HTTPMethod.POST)
    }
    public final func delete(path: String, action: (request: HTTPRequest) -> ()) {
        registerActionForPathWithMethod(action, path: path, method: HTTPMethod.DELETE)
    }
    public final func head(path: String, action: (request: HTTPRequest) -> ()) {
        registerActionForPathWithMethod(action, path: path, method: HTTPMethod.HEAD)
    }
    public final func put(path: String, action: (request: HTTPRequest) -> ()) {
        registerActionForPathWithMethod(action, path: path, method: HTTPMethod.PUT)
    }
}


