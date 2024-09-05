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
    # Check if strings is a list of strings and minLength is an integer
    if not isinstance(strings, list) or not all(isinstance(s, str) for s in strings):
        raise TypeError('strings must be a list of type str')
    if not isinstance(min_length, int):
        raise TypeError('min_length must be an integer')
    # Check if the array is empty
    if(len(strings) == 0):
        return None
    # Iterate through the array and find the first string with a length greater than or equal to min_length
    for string in strings:
        if len(string) >= min_length:
            return string.lower()
    # If no string meets the minimum length, return None
    return None
        
# Write your powers generator here
def powers_generator(*, base: int, exponent: int): #keyword-only input
    for power in range(exponent):
        yield base ** power
    yield None

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
        with open(filename, 'r') as file: # "with" statement automatically checks if file exists, and raises error if not
            for line in file:
                trimmed = line.strip() # strip() function trims whitespace from line
                if trimmed and not trimmed.startswith('#'): # checks if line is not empty nor has # as a starting character
                    count += 1
        return count # returns number of non-empty lines
    except FileNotFoundError:
        raise FileNotFoundError("No such file") # raises specific "No such file" error for testing

# Write your Quaternion class here
@dataclass(frozen=True) # creates Quaternion as a frozen dataclass
class Quaternion:
    a: float
    b: float
    c: float
    d: float

    def __add__(self, other): # metamethod for "+" operator
        return Quaternion(
            self.a + other.a,
            self.b + other.b,
            self.c + other.c,
            self.d + other.d
        )

    def __mul__(self, other): # metamethod for "*" operator
        return Quaternion(
            self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d,
            self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c,
            self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b,
            self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        )

    def __eq__(self, other): # metamethod for "==" operator
        return (self.a == other.a and self.b == other.b and
                self.c == other.c and self.d == other.d)

    def __str__(self): # metamethod for string "" conversion
        parts = []
        if self.a != 0:
            parts.append(f"{self.a}") 
        if self.b != 0:
            parts.append(f"{self.b}i") # adds i, j, and k to end of coefficients for string formatting
        if self.c != 0:
            parts.append(f"{self.c}j")
        if self.d != 0:
            parts.append(f"{self.d}k")
        return "+".join(parts).replace("+-", "-") # puts together parts with + and replaces "+-" with just "-" for better formatting

    @property
    def coefficients(self): # property method that returns coeefficients of Quaternion
        return (self.a, self.b, self.c, self.d) 

    @property
    def conjugate(self): # property method that returns conjugation of Quaternion
        return Quaternion(self.a, -self.b, -self.c, -self.d)