#include <stdexcept>
#include <string>
#include <memory>
using namespace std;

#define MAX_CAPACITY 32768
#define INITIAL_CAPACITY 16

template <typename T>
class Stack {
  unique_ptr<T[]> elements; 
  size_t capacity;          
  size_t top;               
  Stack(const Stack&) = delete;
  Stack& operator=(const Stack&) = delete;

public:
  Stack() : 
    elements(make_unique<T[]>(INITIAL_CAPACITY)),
    capacity(INITIAL_CAPACITY),
    top(0) {}
  size_t size() const {
    return top;
  }
  bool is_empty() const {
    return top == 0;
  }
  bool is_full() const {
    return top == MAX_CAPACITY;
  }
  void push(const T& value) {
    if (is_full()) {
      throw overflow_error("Stack has reached maximum capacity");
    }
    if (top == capacity) {
      reallocate(capacity * 2);
    }
    elements[top++] = value;
  }
  T pop() {
    if (is_empty()) {
      throw underflow_error("cannot pop from empty stack");
    }
    T value = elements[--top];
    if (capacity > INITIAL_CAPACITY && top <= capacity / 4) {
      reallocate(capacity / 2);
    }
    return value;
  }

private:
  void reallocate(size_t new_capacity) {
    if (new_capacity > MAX_CAPACITY) {
      new_capacity = MAX_CAPACITY;
    } 
    else if (new_capacity < INITIAL_CAPACITY) {
      new_capacity = INITIAL_CAPACITY;
    }
    auto new_elements = make_unique<T[]>(new_capacity);
    copy(elements.get(), elements.get() + top, new_elements.get());
    elements = move(new_elements);
    capacity = new_capacity;
  }
};
