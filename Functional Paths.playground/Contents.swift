import Swift

protocol PathNodeType {
    var name : String { get }
}

struct PathNode<PrevType, NextType> : PathNodeType {
    let name : String
}

struct Path<NextType> {
    let nodes : [PathNodeType]
}

prefix operator / { }

prefix func /<NextType>(node : PathNode<Void, NextType>) -> Path<NextType> {
    return Path<NextType>(nodes: [node])
}

func /<PrevType, NextType>(lhs : Path<PrevType>, rhs : PathNode<PrevType, NextType>) -> Path<NextType> {
    return Path<NextType>(nodes: lhs.nodes + [rhs])
}

// Phantom types
enum FirstChild { }
enum SecondChild { }

let modal      = PathNode<Void, FirstChild>(name: "modal")
let tutorial   = PathNode<FirstChild, SecondChild>(name: "tutorial")
let optInAlert = PathNode<SecondChild, Void>(name: "optInAlert")

let path : Path = /modal/tutorial/optInAlert

extension String {
    init<T>(_ path: Path<T>) {
        self = "/" + path.nodes.map({ $0.name }).joinWithSeparator("/")
    }
}

let pathString = String(path) // "/modal/tutorial/optInAlert"

