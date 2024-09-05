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
