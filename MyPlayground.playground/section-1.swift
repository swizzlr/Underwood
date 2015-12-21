// Playground - noun: a place where people can play

import Crack

struct Endpoint {

}

class Barnes: CrackApp {
    func call(request: HTTPRequest) {
        println(request)
    }
}

Barnes().call(HTTPRequest(body: "", headers: Dictionary<String,String>(), path: "", method: .GET))
