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

// Write your Binary Search Tree enum here
