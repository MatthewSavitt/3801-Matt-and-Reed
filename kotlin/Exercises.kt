import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException
import java.io.FileNotFoundException
import java.io.File


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


fun firstThenLowerCase(strings: List<String>, predicate: (String) -> Boolean): String? {
    return strings.firstOrNull(predicate)?.lowercase()
}


class Say(private val words: List<String> = emptyList()) {

    fun and(word: String): Say {
        return Say(words + word)
    }

    val phrase: String
        get() = words.joinToString(" ")
}

fun say(word: String = ""): Say {
    return if (word.isEmpty()) {
        Say()
    } else {
        Say(listOf(word))
    }
}


fun meaningfulLineCount(filename: String): Long {
    if (!File(filename).exists()) {
        throw FileNotFoundException("No such file")
    }
    return BufferedReader(FileReader(filename)).use { reader ->
        reader.lineSequence()
            .filter { it.isNotBlank() && !it.trimStart().startsWith("#") }
            .count().toLong()
    }
}


data class Quaternion(val w: Double, val x: Double, val y: Double, val z: Double) {

    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    val a: Double
        get() = w
    val b: Double
        get() = x
    val c: Double
        get() = y
    val d: Double
        get() = z

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
        val sb = StringBuilder()
        if (w != 0.0) sb.append(w)
        if (x != 0.0) {
            if (sb.isNotEmpty() && x > 0) sb.append("+")
            if (x == -1.0) sb.append("-i") else if (x == 1.0) sb.append("i") else sb.append(x).append("i")
        }
        if (y != 0.0) {
            if (sb.isNotEmpty() && y > 0) sb.append("+")
            if (y == -1.0) sb.append("-j") else if (y == 1.0) sb.append("j") else sb.append(y).append("j")
        }
        if (z != 0.0) {
            if (sb.isNotEmpty() && z > 0) sb.append("+")
            if (z == -1.0) sb.append("-k") else if (z == 1.0) sb.append("k") else sb.append(z).append("k")
        }
        return if (sb.isEmpty()) "0" else sb.toString()
    }
}


sealed interface BinarySearchTree {
    fun contains(nodeValue: String): Boolean
    fun insert(nodeValue: String): BinarySearchTree
    fun size(): Int

    object Empty : BinarySearchTree {
        override fun contains(nodeValue: String): Boolean = false
        override fun insert(nodeValue: String): BinarySearchTree = Node(nodeValue, Empty, Empty)
        override fun size(): Int = 0
        override fun toString(): String = "()"
    }

    data class Node
    (
    val nodeValue: String, 
    val left: BinarySearchTree, 
    val right: BinarySearchTree
    ) : 
    BinarySearchTree {
        override fun contains(nodeValue: String): Boolean {
            return when {
                this.nodeValue == nodeValue -> true
                nodeValue < this.nodeValue -> left.contains(nodeValue)
                else -> right.contains(nodeValue)
            }
        }

        override fun insert(nodeValue: String): BinarySearchTree {
            return when {
                nodeValue < this.nodeValue -> copy(left = left.insert(nodeValue))
                nodeValue > this.nodeValue -> copy(right = right.insert(nodeValue))
                else -> this
            }
        }

        override fun size(): Int = 1 + left.size() + right.size()

        override fun toString(): String = "($left$nodeValue$right)".replace("()", "")
    }
}