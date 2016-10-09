//: [Previous](@previous)

var list = LinkedList<Int>()
list.append(value: 0)
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)

print("Original \(list)")

var copy = list
copy.remove(at: 2)
copy.append(value: 55)
print("Copy \(copy)")
print("List \(list)")
list.value(at: 2)

//: [Next](@next)
