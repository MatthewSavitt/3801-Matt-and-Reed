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


export function firstThenLowerCase(strings, predicate) {
  return strings.find(predicate)?.toLowerCase()
}


export function* powersGenerator({ base, limit }) {
  for (let power = 1; power <= limit; power *= base) {
    yield power
  }
}


export function say(initialString) {
  if (initialString === undefined) {
    return ""
  }
  
  function nextsay(nextString) {
    if (nextString === undefined) {
      return initialString
    }
    else {
      return say(initialString.concat(" ", nextString))
    }
  }
  return nextsay
}


export async function meaningfulLineCount(fileName) {
  let count = 0;
  
  for await (const line of fileName.readLines()) {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith("#")) {
      count++;
    }
  }
  
  return count;
}



export class Quaternion {
  constructor(a, b, c, d) {
    this.a = a
    this.b = b
    this.c = c
    this.d = d
    Object.freeze(this)
  }

  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d)
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d]
  }

  plus(other) {
    return new Quaternion(
      this.a + other.a,
      this.b + other.b,
      this.c + other.c,
      this.d + other.d
    )
  }

  times(other) {
    return new Quaternion(
      this.a * other.a - this.b * other.b - this.c * other.c - this.d * other.d,
      this.a * other.b + this.b * other.a + this.c * other.d - this.d * other.c,
      this.a * other.c - this.b * other.d + this.c * other.a + this.d * other.b,
      this.a * other.d + this.b * other.c - this.c * other.b + this.d * other.a
    )
  }

  equals(other) {
    return (
      this.a === other.a &&
      this.b === other.b &&
      this.c === other.c &&
      this.d === other.d
    )
  }

  toString() {
    const parts = []
    if (this.a !== 0) parts.push(`${this.a}`)
    if (this.b !== 0) {
      if (this.b === 1) parts.push("i")
      else if (this.b === -1) parts.push("-i")
      else parts.push(`${this.b}i`)
    }
    if (this.c !== 0) {
      if (this.c === 1) parts.push("j")
      else if (this.c === -1) parts.push("-j")
      else parts.push(`${this.c}j`)
    }
    if (this.d !== 0) {
      if (this.d === 1) parts.push("k")
      else if (this.d === -1) parts.push("-k")
      else parts.push(`${this.d}k`)
    }
    if (parts.length === 0) return "0"
    let string = parts.join("+")
    string = string.replace(/\+\-/g, "-")
    return string
  }
}
