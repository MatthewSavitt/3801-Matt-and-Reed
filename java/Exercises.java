import java.util.List;
import java.util.Map;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    public static Optional<String> firstThenLowerCase(List<String> strings, Predicate<String> condition) {
        return strings.stream()
                      .filter(condition)
                      .findFirst()
                      .map(String::toLowerCase);
    }

    public static SayPhrase say(String... words) {
        return new SayPhrase(String.join(" ", words));
    }

    public static class SayPhrase {
        private final String phrase;

        private SayPhrase(String phrase) {
            this.phrase = phrase;
        }

        public SayPhrase and(String word) {
            return new SayPhrase(this.phrase + " " + word);
        }

        public String phrase() {
            return this.phrase;
        }
    }

    static long meaningfulLineCount(String filename) throws IOException {
        try (var reader = new BufferedReader(new FileReader(filename))) {
             return reader.lines()
                .map(String::trim)
                .filter(line -> !line.isBlank() && !line.startsWith("#"))
                .count();
        }
    }
}

record Quaternion(double w, double x, double y, double z) {

    public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public static final Quaternion I = new Quaternion(0, 1, 0, 0);
    public static final Quaternion J = new Quaternion(0, 0, 1, 0);
    public static final Quaternion K = new Quaternion(0, 0, 0, 1);

    public Quaternion {
        if (Double.isNaN(w) || Double.isNaN(x) || Double.isNaN(y) || Double.isNaN(z)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }

    public double a() {
        return w;
    }

    public double b() {
        return x;
    }

    public double c() {
        return y;
    }

    public double d() {
        return z;
    }

    public Quaternion plus(Quaternion q) {
        return new Quaternion(this.w + q.w, this.x + q.x, this.y + q.y, this.z + q.z);
    }

    public Quaternion times(Quaternion q) {
        return new Quaternion(
            this.w * q.w - this.x * q.x - this.y * q.y - this.z * q.z,
            this.w * q.x + this.x * q.w + this.y * q.z - this.z * q.y,
            this.w * q.y - this.x * q.z + this.y * q.w + this.z * q.x,
            this.w * q.z + this.x * q.y - this.y * q.x + this.z * q.w
        );
    }

    public Quaternion conjugate() {
        return new Quaternion(this.w, -this.x, -this.y, -this.z);
    }

    public List<Double> coefficients() {
        return Arrays.asList(w, x, y, z);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
    
        if (w != 0.0) {
            sb.append(w);
        }
    
        if (x != 0.0) {
            if (sb.length() > 0 && x > 0) sb.append("+");
            if (x == 1.0) {
                sb.append("i");
            } else if (x == -1.0) {
                sb.append("-i");
            } else {
                sb.append(x).append("i");
            }
        }
    
        if (y != 0.0) {
            if (sb.length() > 0 && y > 0) sb.append("+");
            if (y == 1.0) {
                sb.append("j");
            } else if (y == -1.0) {
                sb.append("-j");
            } else {
                sb.append(y).append("j");
            }
        }

        if (z != 0.0) {
            if (sb.length() > 0 && z > 0) sb.append("+");
            if (z == 1.0) {
                sb.append("k");
            } else if (z == -1.0) {
                sb.append("-k");
            } else {
                sb.append(z).append("k");
            }
        }
        return sb.length() > 0 ? sb.toString() : "0";
    }
}


sealed interface BinarySearchTree permits Node, Empty {
    boolean contains(String nodeValue);
    BinarySearchTree insert(String nodeValue);
    int size();
}

final record Empty() implements BinarySearchTree {

    @Override
    public boolean contains(String nodeValue) {
        return false;
    }

    @Override
    public BinarySearchTree insert(String nodeValue) {
        return new Node(nodeValue, this, this);
    }

    @Override
    public int size() {
        return 0;
    }

    @Override
    public String toString() {
        return "()";
    }
}

final record Node(
String nodeValue, 
BinarySearchTree left, 
BinarySearchTree right) 
implements BinarySearchTree {

    @Override
    public boolean contains(String nodeValue) {
        if (this.nodeValue.equals(nodeValue)) {
            return true;
        }
        if (nodeValue.compareTo(this.nodeValue) < 0) {
            return left.contains(nodeValue);
        } else {
            return right.contains(nodeValue);
        }
    }

    @Override
    public BinarySearchTree insert(String nodeValue) {
        if (nodeValue.compareTo(this.nodeValue) < 0) {
            return new Node(this.nodeValue, left.insert(nodeValue), right);
        } else if (nodeValue.compareTo(this.nodeValue) > 0) {
            return new Node(this.nodeValue, left, right.insert(nodeValue));
        } else {
            return this;
        }
    }

    @Override
    public int size() {
        return 1 + left.size() + right.size();
    }

    @Override
    public String toString() {
        return ("(" + left + nodeValue + right + ")").replace("()", "");
    }
}    
