from dataclasses import dataclass


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


def first_then_lower_case(strings: list, predicate: int, /) -> str: 
    if not strings:
        return None
    for string in strings:
        if predicate(string): 
            return string.lower()


def powers_generator(*, base: int, limit: int): 
    power = 1
    while power <= limit:
        yield power
        power *= base


def say(initial_string = None, /):
    if initial_string is None:
        return ""
    
    def nextsay(next_string = None):
        if next_string is None:  
            return initial_string  
        else:
            return say(initial_string + " " + next_string) 
    return nextsay


def meaningful_line_count(filename, /):
    count = 0
    with open(filename, 'r', encoding='utf-8') as file: 
        for line in file:
            trimmed = line.strip()
            if trimmed and not trimmed.startswith('#'):
                count += 1
    return count 


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
        if self.a != 0:
            parts.append(f"{self.a}")
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
        string = "+".join(parts)
        string = string.replace("+-", "-").replace("+0", "")
        return string

    @property
    def coefficients(self):
        return (self.a, self.b, self.c, self.d)

    @property
    def conjugate(self):
        return Quaternion(self.a, -self.b, -self.c, -self.d)


