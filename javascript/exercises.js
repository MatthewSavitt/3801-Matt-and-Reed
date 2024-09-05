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
export function firstThenLowerCase(strings, minLength) {
  // Check if strings is an array and minLength is a number
  if (!Array.isArray(strings) || typeof minLength !== 'number') {
    throw new TypeError('Invalid arguments: strings must be an array and minLength must be a number');
  }
  // Check if all elements in the strings array are strings
  if (!strings.every(s => typeof s === 'string')) {
    throw new TypeError('Invalid argument: all elements in the strings array must be strings');
  }
  // Check if the array is empty
  if (strings?.length === 0) { //stupid chaining operator
    return undefined;
  }
  // Iterate through the array and find the first string with a length greater than or equal to minLength
  for (const string of strings) {
    if (string.length >= minLength) {
      return string.toLowerCase();
    }
  }
  // If no string meets the minimum length, return undefined
  return undefined;
}

// Write your powers generator here
export function* powersGenerator({base, exponent}) { //destructured
  for (let power = 0; power < exponent; power++) {
    yield base ** power;
  }
  yield null;
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
