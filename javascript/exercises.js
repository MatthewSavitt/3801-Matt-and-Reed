import { open } from "node:fs/promises"

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
  if (strings.length === 0) {
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
export function* powersGenerator(base, exponent) {
  for (let power = 0; power < exponent; power++) {
    yield base ** power;
  }
  yield null;
}

// Write your say function here

// Write your line count function here

// Write your Quaternion class here
