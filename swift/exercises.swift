import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int: Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int: Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

func firstThenLowerCase(of strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return strings.first(where: predicate)?.lowercased()
}

struct Say {
    let phrase: String

    func and(_ word: String) -> Say {
        return Say(phrase: "\(self.phrase) \(word)")
    }
}

func say(_ word: String = "") -> Say {
    return Say(phrase: word)
}

func meaningfulLineCount(filename: String) async -> Result<Int, Error> {
    do {
        let fileHandle = try FileHandle(forReadingFrom: URL(fileURLWithPath: filename))
        defer { try? fileHandle.close() }

        guard let data = try fileHandle.readToEnd() else {
            return .failure(NSError(domain: "Cannot read file", code: 0, userInfo: nil))
        }
        
        let content = String(data: data, encoding: .utf8) ?? ""
        let lineCount = content
            .split(separator: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !$0.trimmingCharacters(in: .whitespaces).starts(with: "#") }
            .count
        return .success(lineCount)
    } catch {
        return .failure(error)
    }
}

struct Quaternion: CustomStringConvertible, Equatable {
    let a: Double
    let b: Double
    let c: Double
    let d: Double

    static let ZERO = Quaternion()
    static let I = Quaternion(b: 1)
    static let J = Quaternion(c: 1)
    static let K = Quaternion(d: 1)

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    static func +(q1: Quaternion, q2: Quaternion) -> Quaternion {
        return Quaternion(
            a: q1.a + q2.a,
            b: q1.b + q2.b,
            c: q1.c + q2.c,
            d: q1.d + q2.d
        )
    }

    static func *(q1: Quaternion, q2: Quaternion) -> Quaternion {
        return Quaternion(
            a: q2.a * q1.a - q2.b * q1.b - q2.c * q1.c - q2.d * q1.d,
            b: q2.a * q1.b + q2.b * q1.a - q2.c * q1.d + q2.d * q1.c,
            c: q2.a * q1.c + q2.b * q1.d + q2.c * q1.a - q2.d * q1.b,
            d: q2.a * q1.d - q2.b * q1.c + q2.c * q1.b + q2.d * q1.a
        )
    }

    var conjugate: Quaternion {
        Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    var coefficients: [Double] {
        [a, b, c, d]
    }

    var description: String {
        let components = zip(coefficients, ["", "i", "j", "k"])
        let terms = components.compactMap { (value, unit) -> String? in
            guard value != 0 else { return nil }
            let absValue = abs(value)
            let valueString = (absValue == 1 && !unit.isEmpty) ? "" : String(absValue)
            return "\(value < 0 ? "-" : "+")\(valueString)\(unit)"
        }
        return terms.isEmpty ? "0" : terms.joined().trimmingCharacters(in: CharacterSet(charactersIn: "+"))
    }
}


indirect enum BinarySearchTree: CustomStringConvertible {
    case empty
    case node(String, BinarySearchTree, BinarySearchTree)

    func contains(_ searchValue: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(nodeValue, left, right):
            if searchValue < nodeValue {
                return left.contains(searchValue)
            } else if searchValue > nodeValue {
                return right.contains(searchValue)
            }
            return true
        }
    }

    func insert(_ newValue: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(newValue, .empty, .empty)
        case let .node(nodeValue, left, right):
            if newValue < nodeValue {
                return .node(nodeValue, left.insert(newValue), right)
            } else if newValue > nodeValue {
                return .node(nodeValue, left, right.insert(newValue))
            } else {
                return self
            }
        }
    }

    var size: Int {
        switch self {
        case .empty:
            return 0
        case let .node(_, left, right):
            return 1 + left.size + right.size
        }
    }

    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(nodeValue, left, right):
            return "(\(left)\(nodeValue)\(right))".replacingOccurrences(of: "()", with: "")
        }
    }
}

