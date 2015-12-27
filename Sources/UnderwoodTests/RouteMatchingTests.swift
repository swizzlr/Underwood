final class RouteMatchingTests: XCTestCase {
  var allTests: [(String, () -> Void)] {
    return [
      ("testSimpleMatch", testSimpleMatch),
      ("testQueries", testQueries),
      ("testPriority", testPriority)
    ]
  }

  func testSimpleMatch() {
    let app = TestApplication()
    let result = app.application(GetAtPath(path: "/something"))
    XCTAssertEqual(result.body, "something")
  }

  func testQueries() {
    let app = TestApplication()
    let result = app.application(GetAtPath(path: "/gimme-params/something?echo-this=hi&foo=bar"))
    XCTAssertEqual(result.body, "hi")
  }

  func testPriority() {
    let app = TestApplication()
    let resultWithWildcardPathParam = app.application(GetAtPath(path: "/wildcard/whatever"))
    XCTAssertEqual(resultWithWildcardPathParam.body, "whatever")
    let resultWithAbsolutePathParam = app.application(GetAtPath(path: "/wildcard/notwildcard"))
    XCTAssertEqual(resultWithAbsolutePathParam.body, "NOT A WILDCARD")
    XCTAssertNotEqual(resultWithAbsolutePathParam.body, "notwildcard")
  }
}

private final class TestApplication: 🇺🇸 {
  override init() {
    super.init()
    get("/:query") { params, _ in
      return Echo(body: params["query"]!)
    }
    get("/gimme-params/something") { _, query in
      return Echo(body: query["echo-this"])
    }
    get("/wildcard/:wildcard_path_param") { params, _ in
      return Echo(body: params["wildcard_path_param"]!)
    }
    get("/wildcard/notwildcard") { _, _ in
      return Echo(body: "NOT A WILDCARD")
    }

  }
}

private struct GetAtPath: RequestType {
  let method: String = "GET"
  let path: String
  let headers: [Header] = []
  let body: String? = nil
}

private struct Echo: ResponseType {
  let statusLine: String = "200 Ok"
  let headers: [Header] = []
  let body: String?
}

import XCTest
import Underwood
import Nest
