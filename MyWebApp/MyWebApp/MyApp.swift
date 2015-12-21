//
//  MyApp.swift
//  MyWebApp
//
//  Created by Swizzlr on 9/1/14.
//  Copyright (c) 2014 swizzlr. All rights reserved.
//

import Underwood

public class MyApp: 🇺🇸 {
    override init() {
        super.init()
        get("/") { (request) -> () in
            println("\(request)")
        }
    }
}