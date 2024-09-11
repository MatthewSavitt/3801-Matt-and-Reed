from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(strings: list, min_length: int) -> str: 
    # Check if the array is empty
    if not strings:
        return None
    # Iterate through the array and find the first string with a length greater than or equal to min_length
    for string in strings:
        if min_length(string): #ugh... I have to do it like this because TECHNICALLY min_length is also a predicate function (for values like nonempty and greater_than_three). So ugly.
            return string.lower()
    # If no string meets the minimum length, return None
    return None
        
# Write your powers generator here
def powers_generator(*, base: int, limit: int): # keyword-only input
    power = 0
    while True:
        current_value = base ** power
        if current_value > limit: 
            break
        yield current_value
        power += 1

# Write your say function here
def say(initial_string = None):
    if initial_string is None:
        return ""
    def inner(next_string = None):
        if next_string is None:  # Check if next_string is None, indicating termination
            return initial_string  # Terminate and return the initial string
        else:
            return say(initial_string + " " + next_string) # Still going? concatenate.
    return inner

# Write your line count function here
def meaningful_line_count(filename):
    try:
        count = 0
        with open(filename, 'r', encoding='utf-8') as file: # "with" statement automatically checks if file exists, and raises error if not, utf-8 for character-reading fix
            for line in file:
                trimmed = line.strip() # strip() function trims whitespace from line
                if trimmed and not trimmed.startswith('#'): # checks if line is not empty nor has # as a starting character
                    count += 1
        return count # returns number of non-empty lines
    except FileNotFoundError:
        raise FileNotFoundError("No such file") # raises specific "No such file" error for testing

# Write your Quaternion class here
@dataclass(frozen=True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float

    def __add__(self, other):
        return Quaternion(
            self.a + other.a,
            self.b + other.b,
            self.c + other.c,
            self.d + other.d
        )

    def __mul__(self, other):
        return Quaternion(
            self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d,
            self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c,
            self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b,
            self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        )

    def __eq__(self, other):
        return (self.a == other.a and self.b == other.b and
                self.c == other.c and self.d == other.d)

    def __str__(self):
        parts = []

        # Add real part (a) if non-zero
        if self.a != 0:
            parts.append(f"{self.a}")

        # Add imaginary parts (i, j, k) if non-zero, ensuring order and proper signs
        if self.b != 0:
            if self.b == 1.0:
                parts.append("i")
            elif self.b == -1.0:
                parts.append("-i")
            else:
                parts.append(f"{self.b}i")

        if self.c != 0:
            if self.c == 1.0:
                parts.append("j")
            elif self.c == -1.0:
                parts.append("-j")
            else:
                parts.append(f"{self.c}j")

        if self.d != 0:
            if self.d == 1.0:
                parts.append("k")
            elif self.d == -1.0:
                parts.append("-k")
            else:
                parts.append(f"{self.d}k")

        if not parts:
            return "0"

        # Ensure proper ordering and joining, fix sign issues
        result = "+".join(parts)
        result = result.replace("+-", "-").replace("+0", "")

        # Special cases for pure imaginary quaternions
        if result == "1i": return "i"
        if result == "-1i": return "-i"
        if result == "1j": return "j"
        if result == "-1j": return "-j"
        if result == "1k": return "k"
        if result == "-1k": return "-k"

        return result

    @property
    def coefficients(self):
        return (self.a, self.b, self.c, self.d)

    @property
    def conjugate(self):
        return Quaternion(self.a, -self.b, -self.c, -self.d)


