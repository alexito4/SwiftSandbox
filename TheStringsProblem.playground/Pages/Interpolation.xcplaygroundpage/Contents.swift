//: [Previous](@previous)

import Foundation

/**
 *  With Literals and interpolation
 */
 
 /*
To have a complete implementation that solves the String Problem we should have a way to create SafeString
 with the native Swift interpolation system.
Without it is really painful to create SafeString by hand like we have done in the "Full Example" page.
But more importanly, if the user calls the fragment initializer with a litarl string that interpolats no safe strings, or safe strings from other type, it will confuse the user.


*/

/*
 First impresion is that it would be nice to have SafeString to be StringLiteralConvertible so we could to
 let xml: XML = "<p>blabla<p>"
 But having this it would break the concat feature of the SafeString, meaning that now this is posible:
 xml1 + "totally not a safe string"
 To mitigate this we could assume that any string literal is not safe. But at that point maybe is no longer worth it.
*/
 // Automatically converting string is not safe, so it assumes is converting plain text.
//extension SafeString: StringLiteralConvertible {
//
//    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
//    public typealias UnicodeScalarLiteralType = StringLiteralType
//
//    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
//        self.init(text: value)
//    }
//
//    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
//        self.init(text: value)
//    }
//
//    public init(stringLiteral value: StringLiteralType) {
//        self.init(text: value)
//    }
//}

/* The StringInterpolationConvertible feature in Swift looks really powerful, especially as we can
overwritte the init with segmens with diferent supported types.
 The porlbem is that the literal string (which we should assume is already safe) is handled in the same way
 as any other interpolated String (which we can not assume is safe), so we cannot distinguish between the two.
 
 In the original post this is posible because the ruby template system is more flexible and allows the user
 to specify whcih kind of string is using when interpolating.
*/
extension SafeString: StringInterpolationConvertible {
    /// Create an instance by concatenating the elements of `strings`.
    public init(stringInterpolation strings: SafeString...) {
        print("concat all")
        self.init(list: strings)
    }
    
    /// Create an instance containing `expr`'s `print` representation.
    public init<T>(stringInterpolationSegment expr: T) {
        print("generic: -\(expr)-")
        self.init(text: String(expr))
    }
    public init(stringInterpolationSegment expr: String) {
        print("string: -\(expr)-")
        self.init(text: expr)
    }
    public init<T where T: StringLiteralConvertible>(stringInterpolationSegment expr: T) {
        print("string literal: -\(expr)-")
        self.init(fragment: String(expr))
    }
    public init(stringInterpolationSegment expr: SafeString) {
        print("safe: -\(expr)-")
        self = expr
    }
}

//let ff: XML = "fragment & <xml>! \(1) \(xml("<p>a<p>"))"

func linkTo(content: XML, url: URL) -> XML {
    // url should be escaped
    return "<a href=\"\(url)\">\(content)</a>" // meeeee the string itself shouldn't be escaped
}

linkTo(xml("click here!"), url: url("http://alejandromp.com"))


//: [Next](@next)
