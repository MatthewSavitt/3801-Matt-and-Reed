import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }
    
    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

// Write your first then lower case function here
fun firstThenLowerCase(list: List<String>, predicate: (String) -> Boolean): String? {
    return list.firstOrNull(predicate)?.lowercase()
}

// Write your say function here
class Say(private val words: MutableList<String> = mutableListOf()) {
    fun and(word: String): Say {
        words.add(word)
        return this
    }

    val phrase: String
        get() = words.joinToString(" ")
}

fun say(word: String = ""): Say {
    return if (word.isEmpty()) {
        Say() 
    } else {
        Say().and(word)
    }
}

// Write your meaningfulLineCount function here
fun meaningfulLineCount(filename: String): Long {
    return BufferedReader(FileReader(filename)).use { reader ->
        reader.lineSequence()
            .filter { it.isNotBlank() && !it.trimStart().startsWith("#") }
            .count().toLong()
    }
}
// Write your Quaternion data class here

// Write your Binary Search Tree interface and implementing classes here
