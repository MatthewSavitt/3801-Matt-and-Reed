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


// Write your BinarySearchTree sealed interface and its implementations here

}
    