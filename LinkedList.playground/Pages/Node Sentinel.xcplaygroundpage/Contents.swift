//: [Previous](@previous)

var str = "Hello, playground"

public
    class Node<T> {
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

extension Node {
    
    // Can't use CustomStringConvertible because playground enters easily in infinite recursion
    public func toString() -> String {
        var text = "["
        var node = next!
        while let value = node._value {
            text += "\(value)"
            node = node.next
            if node._value != nil { text += ", " }
        }
        return text + "]"
    }
}

extension Node {
    public func append(value: T) {
        let newNode = Node()
        newNode.value = value
        
        newNode.next = self
        newNode.previous = previous
        
        previous.next = newNode
        previous = newNode
    }
    
    public func nodeAt(index: Int) -> Node<T>? {
        if index >= 0 {
            var node = next!
            var i = index
            while let _ = node._value {
                if i == 0 { return node }
                i -= 1
                node = node.next
            }
        }
        return nil
    }
    
    public func remove(node: Node<T>) -> T {
        
        node.previous.next = node.next
        node.next.previous = node.previous
        
        return node.value
    }
    
    public func removeAll() {
        assert(_value == nil, "removeAll should only be called in the sentinel node.")
        
        next = self
        previous = self
    }
}

let list = Node<Int>()
list.append(value: 0)
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)
list.append(value: 5)
print(list.toString())

let target = list.nodeAt(index: 3)!
print(target.value)

// target.remove(node: target)  ok
// list.removeAll()             ko
list.next._value
print(list.toString())

print("bye")

let dogBreeds = Node<String>()
dogBreeds.append(value: "Labrador")
dogBreeds.append(value: "Bulldog")
dogBreeds.append(value: "Beagle")
dogBreeds.append(value: "Husky")
print(dogBreeds)
dogBreeds.remove(node: dogBreeds.nodeAt(index: 1)!)
print(dogBreeds.toString())


let numbers = Node<Int>()
numbers.append(value: 5)
numbers.append(value: 10)
numbers.append(value: 15)
print(numbers.toString())

//: [Next](@next)
