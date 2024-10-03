import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

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

    // Write your first then lower case function here
    public static Optional<String> firstThenLowerCase(List<String> strings, Predicate<String> condition) {
        if (strings.isEmpty()) {
            return Optional.empty();  // Return empty Optional if list is empty
        }
        return strings.stream()
                      .filter(condition)  // Filter strings based on the provided condition
                      .findFirst()  // Find the first string that meets the condition
                      .map(String::toLowerCase);  // Convert that string to lower case
    }

    // Write your say function here
    public static SayPhrase say(String... words) {
        // Join the initial words with a space and return a new SayPhrase object (dont trim for preserving whitespace)
        return new SayPhrase(String.join(" ", words));
    }
    // SayPhrase class for chainable phrase building
    public static class SayPhrase {
        private final String phrase;
        // Constructor to initialize the phrase
        private SayPhrase(String phrase) {
            this.phrase = phrase;
        }
        // 'and' method to append more words to the phrase
        public SayPhrase and(String word) {
            return new SayPhrase(this.phrase + " " + word);
        }
        // Read-only 'phrase' method to return the accumulated phrase
        public String phrase() {
            return this.phrase;
        }
    }
    
    // Write your line count function here
    public static long meaningfulLineCount(String fileName) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
            return reader.lines()
                .filter(line -> !line.trim().isEmpty())  // Filter out empty or whitespace-only lines
                .filter(line -> line.trim().charAt(0) != '#')  // Filter out comment lines starting with #
                .count();  // Count the remaining lines
        } catch (FileNotFoundException e) {
            // Custom message to match the test case
            throw new FileNotFoundException("No such file");
        } catch (IOException e) {
            throw new IOException("Error reading the file: " + fileName, e);
        }
    }
    
    // Write your Quaternion record class here
    public record Quaternion(double w, double x, double y, double z) {

        public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
        public static final Quaternion I = new Quaternion(0, 1, 0, 0);
        public static final Quaternion J = new Quaternion(0, 0, 1, 0);
        public static final Quaternion K = new Quaternion(0, 0, 0, 1);
    
        public Quaternion add(Quaternion q) {
            return new Quaternion(this.w + q.w, this.x + q.x, this.y + q.y, this.z + q.z);
        }
    
        public Quaternion multiply(Quaternion q) {
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
    
        public double[] coefficients() {
            return new double[]{w, x, y, z};
        }
    
        @Override
        public String toString() {
            return String.format("(%f, %f, %f, %f)", w, x, y, z);
        }
    }

    // Write your BinarySearchTree sealed interface and its implementations here
    public sealed interface BinarySearchTree permits Node, Empty {

        boolean contains(String value);
        BinarySearchTree insert(String value);
        int size();
        String toString();
    
        final class Empty implements BinarySearchTree {
    
            @Override
            public boolean contains(String value) {
                return false;
            }
    
            @Override
            public BinarySearchTree insert(String value) {
                return new Node(value, this, this);
            }
    
            @Override
            public int size() {
                return 0;
            }
    
            @Override
            public String toString() {
                return "";
            }
        }
    
        final class Node implements BinarySearchTree {
            private final String value;
            private final BinarySearchTree left, right;
    
            public Node(String value, BinarySearchTree left, BinarySearchTree right) {
                this.value = value;
                this.left = left;
                this.right = right;
            }
    
            @Override
            public boolean contains(String value) {
            //checks for if the current node, the left, or the right node contains the requested value.
            //left is lesser, right is greater. Keep recursively calling until value is found or empty case is reached.
                if (this.value.equals(value)) {
                    return true;
                }
                if (value.compareTo(this.value) < 0) {
                    return left.contains(value);
                } else {
                    return right.contains(value);
                }
            }
    
            @Override
            public BinarySearchTree insert(String value) {
            //check is inserted value is lesser or greater than current node's value
            //if lesser, value is inserted as left leaf node
            //if greater, value is inserted as right leaf node.
            //recurse until value is sorted
                if (value.compareTo(this.value) < 0) {
                    return new Node(this.value, left.insert(value), right);
                } else if (value.compareTo(this.value) > 0) {
                    return new Node(this.value, left, right.insert(value));
                } else {
                    return this;
                }
            }
    
            @Override
            public int size() {
                //size will keep recursively being checked and accumulated until final size is obtained.
                return 1 + left.size() + right.size();
            }
    
            @Override
            public String toString() {
                return "(" + left.toString() + value + right.toString() + ")";
            }
        }
    }
}
    