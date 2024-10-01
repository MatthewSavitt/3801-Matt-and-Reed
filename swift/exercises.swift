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
func lowercasedFirst(for array: [String], satisfying predicate: (String) -> Bool) -> String? {
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

func say(_ word: String) -> Say {
    return Say(word)
}

// Write your meaningfulLineCount function here
func countLines(for filename: String) async -> Result<Int, Error> {
    do {
        let content = try await String(contentsOfFile: filename)
        let lines = content.split(whereSeparator: \.isNewline)
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty && !$0.trimmingCharacters(in: .whitespaces).hasPrefix("#") }
        return .success(lines.count)
    } catch {
        return .failure(error)
    }
}
// Write your Quaternion struct here

// Write your Binary Search Tree enum here
