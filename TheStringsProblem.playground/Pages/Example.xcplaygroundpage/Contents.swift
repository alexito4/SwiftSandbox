//: Playground - noun: a place where people can play

import Cocoa


/*
    Using the XML
*/

let f = xml("<em>wow!</em>")
let t = XML(text: "Safety & XML")
//f + "safety & more" // error: binary operator '+' cannot be applied to operands of type 'XML' (aka 'SafeString<XMLString>') and 'String'
f + XML(text: "Safety & More")



/**
*  Using URL
*/

let home: URL = url("http://alejandromp.com/")
//home + "/about"
home + URL(text: "projects")