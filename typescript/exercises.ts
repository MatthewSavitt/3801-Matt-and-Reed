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

export function firstThenApply<T, U>(arr: T[], predicate: (x: T) => boolean, func: (x: T) => U): U | undefined {
  const result = arr.find(predicate);
  return result !== undefined ? func(result) : undefined;
}

export function* powersGenerator(base: bigint): Generator<bigint> {
  let result = 1n;
  while (true) {
      yield result;
      result *= base;
  }
}

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

export type Shape = 
  { kind: "Box", width: number, length: number, depth: number } | 
  { kind: "Sphere", radius: number };

export function surfaceArea(shape: Shape): number {
    if (shape.kind === "Box") {
        return 2 * (shape.width * shape.length + shape.length * shape.depth + shape.width * shape.depth);
    } else {
        return 4 * Math.PI * shape.radius ** 2;
    }
}

export function volume(shape: Shape): number {
    if (shape.kind === "Box") {
        return shape.width * shape.length * shape.depth;
    } else {
        return (4 / 3) * Math.PI * shape.radius ** 3;
    }
}

export interface BinarySearchTree<T> {
  insert(value: T): BinarySearchTree<T>;
  contains(value: T): boolean;
  size(): number;
  inorder(): Generator<T>;
  toString(): string;
}

export class Empty<T> implements BinarySearchTree<T> {
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

export class Node<T> implements BinarySearchTree<T> {
  constructor(
      private readonly value: T,
      private readonly left: BinarySearchTree<T>,
      private readonly right: BinarySearchTree<T>
  ) {}

  insert(value: T): BinarySearchTree<T> {
    if (this instanceof Empty) {
      return new Node(value, new Empty(), new Empty());
    }
    
    if (value < this.value) {
      return new Node(this.value, this.left.insert(value), this.right); // Return new tree with updated left
    } else if (value > this.value) {
      return new Node(this.value, this.left, this.right.insert(value)); // Return new tree with updated right
    } else {
      return this; // If the value is already in the tree, return the same tree
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
    if (!(this instanceof Empty)) {
      yield* this.left.inorder();  // Traverse the left subtree
      yield this.value;            // Yield the current node's value
      yield* this.right.inorder(); // Traverse the right subtree
    }
  }

  toString(): string {
    const leftStr = this.left instanceof Empty ? "" : this.left.toString();
    const rightStr = this.right instanceof Empty ? "" : this.right.toString();
    return `(${leftStr}${this.value}${rightStr})`;
  }
}