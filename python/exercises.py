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
def first_then_lower_case(strings: list[str], min_length: int) -> str | None: # <-- If no string meets the minimum length, return None
    # Check if strings is an array and min_length is a number
    if not isinstance(strings, list[str]):
        raise TypeError('strings must be a list of type str')
    elif not isinstance(min_length, int):
        raise TypeError('min_length must be a number')
    # Check if the array is empty
    if(strings.len() == 0):
        return None
    # Iterate through the array and find the first string with a length greater than or equal to min_length
    for string in strings:
        if string.len() >= min_length:
            return string.lower()
        
# Write your powers generator here
def powers_generator(base: int, exponent: int):
    for power in range(exponent):
        yield base ** power
    yield None

# Write your say function here


# Write your line count function here


# Write your Quaternion class here
