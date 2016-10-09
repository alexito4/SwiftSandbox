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

public class LinkedList<T> {
    
    let sentinel = Node<T>()
    
    public func append(value: T) {
        let newNode = Node<T>()
        newNode.value = value
        
        newNode.next = sentinel
        newNode.previous = sentinel.previous
        
        sentinel.previous.next = newNode
        sentinel.previous = newNode
    }
    
    public func node(at index: Int) -> Node<T>? {
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
    
    public func remove(_ node: Node<T>) -> T {
        
        node.previous.next = node.next
        node.next.previous = node.previous
        
        return node.value
    }
    
    public func removeAll() {
        sentinel.next = sentinel
        sentinel.previous = sentinel
    }
}

extension LinkedList {
    
    public func remove(at index: Int) -> T? {
        let found = node(at: index)
        guard let node = found else { return nil }
        return remove(node)
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

let list = LinkedList<Int>()
list.append(value: 0)
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)
print(list)
print(list.map({$0*2}))

let target = list.node(at: 3)!
print(target.value)

list.remove(target)
list

list.removeAll()

print("bye")

let heroes = LinkedList<String>()
heroes.append(value: "Iron Man")
heroes.append(value: "Spiderman")
heroes.append(value: "Hulk")
heroes.append(value: "Batman")
print(heroes)
heroes.remove(heroes.node(at: 2)!)
print(heroes)
heroes.remove(at: 2)
print(heroes)

//: [Next](@next)
