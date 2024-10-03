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
data class Quaternion(val w: Double, val x: Double, val y: Double, val z: Double) {

    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    operator fun plus(q: Quaternion): Quaternion {
        return Quaternion(w + q.w, x + q.x, y + q.y, z + q.z)
    }

    operator fun times(q: Quaternion): Quaternion {
        return Quaternion(
            w * q.w - x * q.x - y * q.y - z * q.z,
            w * q.x + x * q.w + y * q.z - z * q.y,
            w * q.y - x * q.z + y * q.w + z * q.x,
            w * q.z + x * q.y - y * q.x + z * q.w
        )
    }

    fun conjugate(): Quaternion {
        return Quaternion(w, -x, -y, -z)
    }

    fun coefficients(): List<Double> {
        return listOf(w, x, y, z)
    }

    override fun toString(): String {
        return "($w, $x, $y, $z)"
    }
}

// Write your Binary Search Tree interface and implementing classes here
sealed interface BinarySearchTree {
    fun contains(value: String): Boolean
    fun insert(value: String): BinarySearchTree
    fun size(): Int

    object Empty : BinarySearchTree {
        override fun contains(value: String): Boolean = false
        override fun insert(value: String): BinarySearchTree = Node(value, Empty, Empty)
        override fun size(): Int = 0
        override fun toString(): String = ""
    }

    data class Node(val value: String, val left: BinarySearchTree, val right: BinarySearchTree) : BinarySearchTree {
        override fun contains(value: String): Boolean {
            return when {
                this.value == value -> true
                value < this.value -> left.contains(value)
                else -> right.contains(value)
            }
        }

        override fun insert(value: String): BinarySearchTree {
            return when {
                value < this.value -> copy(left = left.insert(value))
                value > this.value -> copy(right = right.insert(value))
                else -> this
            }
        }

        override fun size(): Int = 1 + left.size() + right.size()

        override fun toString(): String = "($left$value$right)"
    }
}