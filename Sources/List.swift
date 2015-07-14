public enum List<T> {
    case Nil
    case Cons(Wrap<T>, Wrap<List>)

    public init(_ arr: [T]) {
        self = listFromSlice(arr[0..<arr.count])
    }

    public init(_ args: T...) {
        self = listFromSlice(args[0..<args.count])
    }

    public func map<S>(f: (T) -> S) -> List<S> {
        switch self {
        case .Nil:
            return List<S>.Nil
        case let .Cons(head, tail):
            return List<S>.Cons(Wrap(f(head.value)), Wrap(tail.value.map(f)))
        }
    }

    public func toArray() -> [T] {
        var arr = [T]()
        var list = self
        while case let .Cons(head, tail) = list {
            arr.append(head.value)
            list = tail.value
        }
        return arr
    }
}

public func Cons<T>(head: T, _ tail: List<T>) -> List<T> {
    return .Cons(Wrap(head), Wrap(tail))
}

func listFromSlice<T>(arr: ArraySlice<T>) -> List<T> {
    if arr.count == 0 { return List.Nil }
    return Cons(arr[0], listFromSlice(arr[1..<arr.count]))
}

public func ListFromString(str: String) -> List<Character> {
    var arr = [Character]()
    for c in str.characters {
        arr.append(c)
    }
    return listFromSlice(arr[0..<arr.count])
}

public func ListToString(var list: List<Character>) -> String {
    var str = ""
    while case let .Cons(head, tail) = list {
        str.append(head.value)
        list = tail.value
    }
    return str
}
