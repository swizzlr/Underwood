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
    let route = self.routes[index]
    return route.action(params: route.parametersForPath(request.path))
  }
}

internal struct Route: Equatable, Hashable {
  private func match(path: String, method: HTTPMethod) -> Bool {
    return method == self.method && matchPath(path)
  }
  private func matchPath(path: String) -> Bool {
    guard self.path != path else {
      return true // Shortcut expensive computations below
    }
    let components = path.pathComponents
    guard PathComponent.matchPaths(components, self.path.pathComponents) else {
      return false
    }
    // We now have two paths that match.
    return true
  }

  private let method: HTTPMethod
  private let path: String
  var hashValue: Int {
    return (method.rawValue.hashValue ^ path.hashValue)
  }
  /// Returns the dictionary of path parameters, if any.
  /// Calling this method assumes that `self.matchPath(path)` is true
  internal func parametersForPath(path: String) -> [String:String] {
    precondition(self.matchPath(path))
    let inputPath = path.pathComponents
    let template = self.path.pathComponents
    let zipped = zip(inputPath, template)
    var returnDict: [String:String] = [:]
    for (input, template) in zipped {
      guard case let .Variable(key) = template,
        case let .Variable(value) = input else {
          continue
        }
      returnDict[key] = value
    }
    return returnDict
  }
  internal let action: 🇺🇸.Action
  private enum PathComponent {
    case Constant(String)
    case Variable(String)
    static func fromString(string: String) -> PathComponent {
      if string.hasPrefix(":") {
        var str = string
        str.removeAtIndex(str.startIndex)
        return .Variable(str)
      } else {
        return .Constant(string)
      }
    }
    func match(other: PathComponent) -> Bool {
      switch (self, other) {
      case let (.Constant(l), .Constant(r)):
        return l == r
      case (.Variable, .Variable):
        return true
      default: return false
      }
    }
    static func matchPaths(lhs: [PathComponent], _ rhs: [PathComponent]) -> Bool {
      guard lhs.count == rhs.count else { return false }
      for (left, right) in zip(lhs, rhs) {
        guard left.match(right) else {
          return false
        }
      }
      return true
    }
  }
}

private extension String {
  /// Splits a string with / assuming UTF-8 encoding. O(n)
  func splitPath() -> [String] {
    return characters.split { $0 == "/" }
      .map(String.init)
  }
  /// O(n)
  var pathComponents: [Route.PathComponent] {
    return splitPath().map(Route.PathComponent.fromString)
  }
}

internal func ==(lhs: Route, rhs: Route) -> Bool {
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
import Foundation
