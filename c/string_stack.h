#ifndef STRING_STACK_H
#define STRING_STACK_H

#include <stdbool.h>

#define MAX_CAPACITY 32768
#define MAX_ELEMENT_BYTE_SIZE 256

typedef struct _Stack* stack;

typedef enum {
  success,
  out_of_memory,
  stack_element_too_large,
  stack_full,
  stack_empty
} response_code;

typedef struct {
    response_code code;
    stack stack;
} stack_response;

typedef struct {
    response_code code;
    char* string;
} string_response;

stack_response create();

int size(const stack s);
bool is_empty(const stack s);
bool is_full(const stack s);

response_code push(stack s, char* item);
string_response pop(stack s);

void destroy(stack* s);

#endif
