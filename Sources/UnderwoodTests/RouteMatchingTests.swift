final class RouteMatchingTests: XCTestCase {
  var allTests: [(String, () -> Void)] {
    return [
      ("testSimpleMatch", testSimpleMatch)
    ]
  }

  func testSimpleMatch() {
    let app = TestApplication()
    let result = app.application(GetAtPath(path: "/something"))
    XCTAssertEqual(result.body, "something")
  }
}

private final class TestApplication: 🇺🇸 {
  private var called: [String] = []
  override init() {
    super.init()
    get("/:query") { params in
      self.called.append(params["query"]!)
      return Echo(body: params["query"]!)
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
