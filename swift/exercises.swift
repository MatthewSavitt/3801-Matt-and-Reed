import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// Write your first then lower case function here
func firstThenLowerCase(of array: [String], satisfying predicate: (String) -> Bool) -> String? {
    return array.first(where: predicate)?.lowercased()
}

// Write your say function here
class Say {
    private var words: [String]

    init(_ word: String) {
        self.words = [word]
    }

    func and(_ word: String) -> Say {
        words.append(word)
        return self
    }

    var phrase: String {
        return words.joined(separator: " ")
    }
}

func say(_ word: String = "") -> Say {
    return Say(word)
}

// Define your custom error
struct NoSuchFileError: Error {}

// Updated function signature without argument labels to match test calls
func meaningfulLineCount(in path: String) async throws -> Int {
    let fileURL = URL(fileURLWithPath: path)
    let fileHandle = try FileHandle(forReadingFrom: fileURL)
    // Read the contents of the file asynchronously
    guard let data = try await fileHandle.readToEnd() else {
        throw NSError(domain: "Cannot read file", code: 0, userInfo: nil)
    }
    try fileHandle.close()
    // Convert data to a string using UTF-8 encoding
    guard let content = String(data: data, encoding: .utf8) else {
        throw NSError(domain: "Cannot decode file", code: 0, userInfo: nil)
    }
    // Split the content into lines, including empty lines
    let lines = content.split(separator: "\n", omittingEmptySubsequences: false)
    // Filter out lines that are purely whitespace or start with '#'
    let filteredLines = lines.filter { line in
        let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedLine.isEmpty && !trimmedLine.hasPrefix("#")
    }
    // Return the count of the filtered lines
    return filteredLines.count
}

// Write your Quaternion struct here
struct Quaternion {
    let w: Double
    let x: Double
    let y: Double
    let z: Double

    static let zero = Quaternion(w: 0, x: 0, y: 0, z: 0)
    static let i = Quaternion(w: 0, x: 1, y: 0, z: 0)
    static let j = Quaternion(w: 0, x: 0, y: 1, z: 0)
    static let k = Quaternion(w: 0, x: 0, y: 0, z: 1)

    func add(_ q: Quaternion) -> Quaternion {
        return Quaternion(w: w + q.w, x: x + q.x, y: y + q.y, z: z + q.z)
    }

    func multiply(_ q: Quaternion) -> Quaternion {
        return Quaternion(
            w: w * q.w - x * q.x - y * q.y - z * q.z,
            x: w * q.x + x * q.w + y * q.z - z * q.y,
            y: w * q.y - x * q.z + y * q.w + z * q.x,
            z: w * q.z + x * q.y - y * q.x + z * q.w
        )
    }

    func conjugate() -> Quaternion {
        return Quaternion(w: w, x: -x, y: -y, z: -z)
    }

    func coefficients() -> [Double] {
        return [w, x, y, z]
    }

    var description: String {
        return "(\(w), \(x), \(y), \(z))"
    }
}

// Write your Binary Search Tree enum here
indirect enum BinarySearchTree {
    case empty
    case node(String, BinarySearchTree, BinarySearchTree)

    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(v, left, right):
            if v == value {
                return true
            } else if value < v {
                return left.contains(value)
            } else {
                return right.contains(value)
            }
        }
    }

    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(value, .empty, .empty)
        case let .node(v, left, right):
            if value < v {
                return .node(v, left.insert(value), right)
            } else if value > v {
                return .node(v, left, right.insert(value))
            } else {
                return self
            }
        }
    }

    func size() -> Int {
        switch self {
        case .empty:
            return 0
        case let .node(_, left, right):
            return 1 + left.size() + right.size()
        }
    }

    var description: String {
        switch self {
        case .empty:
            return ""
        case let .node(value, left, right):
            return "(\(left.description)\(value)\(right.description))"
        }
    }
}