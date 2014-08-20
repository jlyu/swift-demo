// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var myVar = 42.2
let myLet = 23

println("I have \(myVar) JPY")

// Array and Dictionary
let emptyArray = [String]()  // or shoppingList = []
let emptyDictionary = [String: Int]() // or numberCheck = [:]

// Optional
var optionalVar: Int? = 42 // nil
if let myInt = optionalVar {
    println(myInt)
} else {
    println("var is nil")
}


// @autoclousure
func logIfTrue(predicate: @autoclosure ()-> Bool) {
    if predicate() {
        println("True")
    }
}

logIfTrue(2 > 1)


// ??
// func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T

var level: Int? = 2
let defaultLv = 1
let currentLv = level ?? defaultLv

// Truple
func swapValue<T>(inout a: T, inout b: T) {
    (a, b) = (b, a)
}
var testA = 42
var testB = 23
swapValue(&testA, &testB)

func returnTruple(#isOK: Bool) -> (Bool, NSError?) {
    if isOK {
        return (true, nil)
    } else {
        return (false, NSError(domain: "SomeError", code: 404, userInfo: nil))
    }
}
returnTruple(isOK: false)

var num = 42
println(num)
println(num.0.0.0.0.0.0.0.0.0.0)