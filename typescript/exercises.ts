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
type Shape = { kind: "box", width: number, length: number, depth: number } | { kind: "sphere", radius: number };

function surfaceArea(shape: Shape): number {
    if (shape.kind === "box") {
        return 2 * (shape.width * shape.length + shape.length * shape.depth + shape.width * shape.depth);
    } else {
        return 4 * Math.PI * shape.radius ** 2;
    }
}

function volume(shape: Shape): number {
    if (shape.kind === "box") {
        return shape.width * shape.length * shape.depth;
    } else {
        return (4 / 3) * Math.PI * shape.radius ** 3;
    }
}

// Write your binary search tree implementation here
interface BinarySearchTree<T> {
  insert(value: T): BinarySearchTree<T>;
  contains(value: T): boolean;
  size(): number;
  inorder(): Generator<T>;
  toString(): string;
}

class Empty<T> implements BinarySearchTree<T> {
  insert(value: T): BinarySearchTree<T> {
      return new Node<T>(value, new Empty<T>(), new Empty<T>());
  }

  contains(_: T): boolean {
      return false;
  }

  size(): number {
      return 0;
  }

  *inorder(): Generator<T> {}

  toString(): string {
      return "()";
  }
}

class Node<T> implements BinarySearchTree<T> {
  constructor(
      private readonly value: T,
      private readonly left: BinarySearchTree<T>,
      private readonly right: BinarySearchTree<T>
  ) {}

  insert(value: T): BinarySearchTree<T> {
      if (value < this.value) {
          return new Node<T>(this.value, this.left.insert(value), this.right);
      } else if (value > this.value) {
          return new Node<T>(this.value, this.left, this.right.insert(value));
      } else {
          return this; // Value already exists, so no change to the tree.
      }
  }

  contains(value: T): boolean {
      if (value === this.value) {
          return true;
      } else if (value < this.value) {
          return this.left.contains(value);
      } else {
          return this.right.contains(value);
      }
  }

  size(): number {
      return 1 + this.left.size() + this.right.size();
  }

  *inorder(): Generator<T> {
      yield* this.left.inorder();
      yield this.value;
      yield* this.right.inorder();
  }

  toString(): string {
      return `(${this.left.toString()}${this.value}${this.right.toString()})`;
  }
}