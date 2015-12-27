public class 🇺🇸 {
  public init() {}
  private final var routes: Set<Route> = []

  private func registerActionForPathWithMethod(action: Action, path: String, method: HTTPMethod) {
    let route = Route(method: method, path: path, action: action)
    routes.insert(route)
  }
  public typealias Action = (params: [String:String]) -> (ResponseType)
  public final func get(path: String, action: Action) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.GET)
  }
  public final func post(path: String, action: Action) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.POST)
  }
  public final func delete(path: String, action: Action) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.DELETE)
  }
  public final func head(path: String, action: Action) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.HEAD)
  }
  public final func put(path: String, action: Action) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.PUT)
  }
  public final func application(request: RequestType) -> ResponseType {
    guard let method = HTTPMethod(rawValue: request.method),
    let index = self.routes.indexOf({ $0.match(request.path, method: method) }) else {
      return NotFound()
    }
    return self.routes[index].action(params: [:])
  }
}

private struct Route: Equatable, Hashable {
  func match(path: String, method: HTTPMethod) -> Bool {
    return path == self.path && method == self.method
  }
  let method: HTTPMethod
  let path: String
  var hashValue: Int {
    return (method.rawValue.hashValue ^ path.hashValue)
  }
  let action: 🇺🇸.Action
}

private func ==(lhs: Route, rhs: Route) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

private struct NotFound: ResponseType {
  let statusLine: String = "404 Not Found"
  let headers: [Header] = []
  let body: String? = nil
}

private enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case HEAD
  case DELETE
}
import Nest
