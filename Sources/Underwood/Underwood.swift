public class 🇺🇸 {
  public init() {}
  private final var pathToMethodActionMap: Dictionary<String, Dictionary<HTTPMethod, ((request: RequestType) -> (ResponseType))>> = Dictionary();

  private func registerActionForPathWithMethod(action: (request: RequestType) -> (ResponseType), path: String, method: HTTPMethod) {
    if let methodActionMap = pathToMethodActionMap[path] {
      var methodActionMap = methodActionMap
      methodActionMap.updateValue(action, forKey: method)
      pathToMethodActionMap[path] = methodActionMap
    } else {
      let newActionMethodMap = [method: action]
      pathToMethodActionMap[path] = newActionMethodMap
    }
  }

  public final func get(path: String, action: (request: RequestType) -> (ResponseType)) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.GET)
  }
  public final func post(path: String, action: (request: RequestType) -> (ResponseType)) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.POST)
  }
  public final func delete(path: String, action: (request: RequestType) -> (ResponseType)) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.DELETE)
  }
  public final func head(path: String, action: (request: RequestType) -> (ResponseType)) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.HEAD)
  }
  public final func put(path: String, action: (request: RequestType) -> (ResponseType)) {
    registerActionForPathWithMethod(action, path: path, method: HTTPMethod.PUT)
  }
  public final func application(request: RequestType) -> ResponseType {
    guard let method = HTTPMethod(rawValue: request.method), let action = pathToMethodActionMap[request.path]?[method] else {
      return NotFound()
    }
    return action(request: request)
  }
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
