//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

public class Node<T> {
    
    var value: T {
        get {
            return _value!
        }
        set {
            _value = newValue
        }
    }
    var _value: T?
    
    var next: Node!
    var previous: Node!
    
    init() {
        next = self
        previous = self
    }
    
}
extension LinkedList {
    
    mutating func copy() -> LinkedList<T> {
        var copy = LinkedList<T>()
        for node in self {
            copy.append(value: node)
        }
        return copy
    }
    
}

public struct LinkedList<T> {
    
    fileprivate var sentinel = Node<T>()
    private var mutableSentinel: Node<T> {
        mutating get {
            if !isKnownUniquelyReferenced(&sentinel) {
                sentinel = self.copy().sentinel
            }
            return sentinel
        }
    }
    
    public mutating func append(value: T) {
        let newNode = Node<T>()
        newNode.value = value
        
        let sentinel = mutableSentinel
        
        newNode.next = sentinel
        newNode.previous = sentinel.previous
        
        sentinel.previous.next = newNode
        sentinel.previous = newNode
    }
    
    public func value(at index: Int) -> T? {
        return node(at: index)?.value
    }
    
    private func node(at index: Int) -> Node<T>? {
        if index >= 0 {
            var node = sentinel.next!
            var i = index
            while let _ = node._value {
                if i == 0 { return node }
                i -= 1
                node = node.next
            }
        }
        return nil
    }
    
    public mutating func remove(at index: Int) -> T? {
        let _ = mutableSentinel

        let found = node(at: index)
        guard let node = found else { return nil }
        return remove(node)
    }
    
    public func remove(_ node: Node<T>) -> T {
        
        node.previous.next = node.next
        node.next.previous = node.previous
        
        return node.value
    }
    
    public mutating func removeAll() {
        let sentinel = mutableSentinel

        sentinel.next = sentinel
        sentinel.previous = sentinel
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        var text = "["
        var node = sentinel.next!
        while let value = node._value {
            text += "\(value)"
            node = node.next
            if node._value != nil { text += ", " }
        }
        return text + "]"
    }
    
}

public struct LinkedListIterator<T>: IteratorProtocol {
    var node: Node<T>
    
    mutating public func next() -> T? {
        let next = node.next!
        guard let value = next._value else { return nil }
        defer { node = next }
        return value
    }
}

extension LinkedList: Sequence {
    
    public func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(node: sentinel)
    }
}

var list = LinkedList<Int>()
list.append(value: 0)
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)

print("Original \(list)")
var copy = list
copy.remove(at: 2)
print("Copy \(copy)")
print("List \(list)")
list.value(at: 2)


//: [Next](@next)
