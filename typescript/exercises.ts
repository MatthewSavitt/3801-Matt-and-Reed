import { open } from "node:fs/promises"

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then apply function here
export function firstThenApply<T, U>(arr: T[], predicate: (x: T) => boolean, func: (x: T) => U): U | undefined {
  const result = arr.find(predicate);
  return result !== undefined ? func(result) : undefined;
}

// Write your powers generator here
export function* powersGenerator(base: bigint): Generator<bigint> {
  let result = 1n;
  while (true) {
      yield result;
      result *= base;
  }
}

// Write your line count function here
export async function meaningfulLineCount(filePath: string): Promise<number> {
    const fileHandle = await open(filePath, 'r');
    try {
        const fileContent: string = await fileHandle.readFile('utf-8');
        const lines: string[] = fileContent.split('\n');
        return lines.filter((line: string) => {
            const trimmed: string = line.trim();
            return trimmed.length > 0 && !trimmed.startsWith('#');
        }).length;
    } finally {
        await fileHandle.close();
    }
}

// Write your shape type and associated functions here


// Write your binary search tree implementation here
