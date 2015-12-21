//
//  main.swift
//  MyWebApp
//
//  Created by Swizzlr on 8/29/14.
//  Copyright (c) 2014 swizzlr. All rights reserved.
//

import Underwood
import Crack

let server = MyApp()
let request = HTTPRequest(body: "", headers: ["Accept-Encoding": "utf-8"], path: "/", method: .GET)
server.call(request)
