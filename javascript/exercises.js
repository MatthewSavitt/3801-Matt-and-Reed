import { open } from "node:fs/promises"
import { readFile } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(strings, min_length) {
  // Check if the array is empty
  if (strings?.length === 0) {
    return undefined;
  }
  // Iterate through the array and find the first string with a length greater than or equal to min_length
  for (const element of strings) {
    if (min_length(element)) { // type coercion to check for length
      return element.toLowerCase();
    }
  }
  // If no string meets the minimum length, return nil
  return undefined;
}

// Write your powers generator here
export function* powersGenerator({ base, exponent }) {
  if (typeof base !== 'number' || typeof exponent !== 'number' || exponent < 0) {
    throw new TypeError('Invalid arguments: base must be a number and exponent must be a positive number');
  }
  let currentPower = 1;
  while (currentPower <= exponent) {
    yield currentPower;
    currentPower *= base;
  }
  return undefined;
}

// Write your say function here
export function say(initialString) {
  if (initialString === undefined) {
    return "";
  }
  function inner(nextString) {
    if (nextString === undefined) { // Check if next_string is None, indicating termination
      return initialString; // Terminate and return the initial string
    }
    else {
      return say(initialString.concat(" ", nextString)); // Still going? concatenate.
    }
  }
  return inner
}

// Write your line count function here
export async function meaningfulLineCount(filename) {
    try {
        const file = await fs.readFile(filename, 'utf-8'); // Read the file asynchronously
        const lines = file.split('\n'); // Split the file content by newlines
        let count = 0;

        for (let line of lines) {
            const trimmed = line.trim(); // Trim whitespace from each line
            if (trimmed && !trimmed.startsWith('#')) { // Count non-empty lines that don't start with '#'
                count++;
            }
        }

        return count; // Return the meaningful line count
    } catch (err) {
        return Promise.reject(new Error('No such file')); // Propagate the rejection properly
    }
}

// Write your Quaternion class here
export class Quaternion {
  constructor(a, b, c, d) {
      this.a = a;
      this.b = b;
      this.c = c;
      this.d = d;
      Object.freeze(this); // Freeze the object to make it immutable
  }

  // Getter for conjugate
  get conjugate() {
      return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }

  // Getter for coefficients
  get coefficients() {
      return [this.a, this.b, this.c, this.d];
  }

  // Addition operation
  plus(other) {
      return new Quaternion(
          this.a + other.a,
          this.b + other.b,
          this.c + other.c,
          this.d + other.d
      );
  }

  // Multiplication operation
  times(other) {
      return new Quaternion(
          this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
          this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
          this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
          this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
      );
  }

  // Equality check
  equals(other) {
      return (
          this.a === other.a &&
          this.b === other.b &&
          this.c === other.c &&
          this.d === other.d
      );
  }

  // String representation
  toString() {
      const parts = [];

      if (this.a !== 0) parts.push(`${this.a}`);

      if (this.b !== 0) {
          if (this.b === 1) parts.push("i");
          else if (this.b === -1) parts.push("-i");
          else parts.push(`${this.b}i`);
      }

      if (this.c !== 0) {
          if (this.c === 1) parts.push("j");
          else if (this.c === -1) parts.push("-j");
          else parts.push(`${this.c}j`);
      }

      if (this.d !== 0) {
          if (this.d === 1) parts.push("k");
          else if (this.d === -1) parts.push("-k");
          else parts.push(`${this.d}k`);
      }

      if (parts.length === 0) return "0";

      // Ensure proper ordering and joining, fix sign issues
      let result = parts.join("+");

      // Replace all instances of "+-" with "-"
      result = result.replace(/\+\-/g, "-");
      return result;
  }
}
