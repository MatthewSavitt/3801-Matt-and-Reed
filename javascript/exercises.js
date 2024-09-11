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
      const file = await fs.readFile(filename, 'utf-8'); // Uses fs.promises.readFile to read file asynchronously to check it it exists
      const lines = file.split('\n'); // Splits lines of file for iteration
      let count = 0;

      for (let line of lines) {
          const trimmed = line.trim(); // Trim() function to trim whitespace of line
          if (trimmed && !trimmed.startsWith('#')) { // Checks if line is not empty nor has # as a starting character
              count++;
          }
      }

      return count; // Returns number of non-empty lines
  } catch (err) {
      throw new Error('No such file'); // Rejected promise propagates if file not found
  }
}

// Write your Quaternion class here
export class Quaternion {
  constructor(a, b, c, d) {  // Creates Quaternion
      this.a = a;
      this.b = b;
      this.c = c;
      this.d = d;
      Object.freeze(this); // Makes the Quaternion immutable
  }

  plus(other) { // method for Quaternion addition
      return new Quaternion(
          this.a + other.a,
          this.b + other.b,
          this.c + other.c,
          this.d + other.d
      );
  }

  times(other) { // method for Quaternion multiplication
      return new Quaternion(
          this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
          this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
          this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
          this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
      );
  }

  equals(other) { // method for Quaternion equality
      return this.a === other.a && this.b === other.b &&
             this.c === other.c && this.d === other.d;
  }

  get coefficients() { // getter method for coefficients in Quaternion
      return [this.a, this.b, this.c, this.d];
  }

  get conjugate() { // getter method for conjugation of Quaternion
      return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }

  toString() {
    const parts = [];
    if (this.a !== 0) parts.push(this.a === 1 ? "" : `${this.a}`);
    if (this.b !== 0) parts.push(this.b === 1 ? "i" : `${this.b}i`);
    if (this.c !== 0) parts.push(this.c === 1 ? "j" : `${this.c}j`);
    if (this.d !== 0) parts.push(this.d === 1 ? "k" : `${this.d}k`);
  
    // Check if all coefficients are zero
    if (parts.length === 0) {
      return "0";
    } else {
      // Handle negative coefficients with a "-" sign
      return parts.join("+").replace(/\+\-/g, "-").replace(/^-1/, "-");
    }
  }
}