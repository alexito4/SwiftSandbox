import Foundation

/**
 *  SafeXML
 */

public struct XMLString: Language {
    
    let xml: String
    
    public init(fragment: String) {
        xml = fragment
    }
    
    public init(plainText: String) {
        xml = escapeXML(plainText)
    }
    
    public func toString() -> String {
        return xml
    }
    
    public let name = "XML"
}

func escapeXML(xml: String) -> String {
    return CFXMLCreateStringByEscapingEntities(nil, xml, nil) as String
}

public typealias XML = SafeString<XMLString>

public func xml(fragment: String) -> XML {
    return XML(fragment: fragment)
}


