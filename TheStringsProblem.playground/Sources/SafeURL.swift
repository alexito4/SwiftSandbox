import Foundation

public struct URLString: Language {
    
    let url: String
    
    public init(fragment: String) {
        url = fragment
    }
    
    public init(plainText: String) {
        url = plainText.urlEncoded
    }
    
    public func toString() -> String {
        return url
    }
    
    public let name = "URL"
}

extension String {
    var urlEncoded: String {
        return CFURLCreateStringByAddingPercentEscapes(nil, self, nil, "!*'();:@&=+$,/?%#[]\"", CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
}

public typealias URL = SafeString<URLString>

public func url(text: String) -> URL {
    return URL(fragment: text)
}
