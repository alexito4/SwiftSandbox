
public protocol Language {
    // litfrag  :: String -> l   -- String is a literal language fragment
    init(fragment: String)
    
    // littext  :: String -> l   -- String is literal text
    init(plainText: String)
    
    // natrep   :: l -> String   -- Gets the native-language representation
    func toString() -> String
    
    // language :: l -> String   -- Gets the name of the language
    var name: String { get }
}

public enum SafeString<T: Language> {
    case Empty
    case Fragment(fragment: T)
    indirect case Concat(left: SafeString, right: SafeString)
    
    public init() {
        self = .Empty
    }
    
    public init(fragment: String) {
        self = .Fragment(fragment: T(fragment: fragment))
    }
    
    public init(text: String) {
        self = .Fragment(fragment: T(plainText: text))
    }
    
    // cat -- join a list of same-language SafeStrings
    public init(list: [SafeString<T>]) {
        self = list.reduce(SafeString(), combine: { $0 + $1 })
    }
}

// -- join two SafeStrings of the same language
public func +<T>(left: SafeString<T>, right: SafeString<T>) -> SafeString<T> {
    return SafeString.Concat(left: left, right: right)
}

extension SafeString {
    // maybe this could be changed by each language
    private var id: String {
        return ""
    }
    public func render() -> String {
        switch self {
        case .Empty: return id
        case .Fragment(let fragment): return fragment.toString()
        case .Concat(let left, let right): return left.render() + right.render()
        }
    }
}

extension SafeString: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return self.render()
    }
    
}
