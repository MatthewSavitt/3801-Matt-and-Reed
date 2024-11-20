#include "string_stack.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct _Stack {
    char** data;
    int size;
    int capacity;
} _Stack;

static response_code resize_stack(stack s, int new_capacity) {
    if (new_capacity > MAX_CAPACITY || new_capacity < 16) {
        return out_of_memory;
    }
    char** new_data = realloc(s->data, new_capacity * sizeof(char*));
    if (new_data == NULL) {
        return out_of_memory;
    }
    s->data = new_data;
    s->capacity = new_capacity;
    return success;
}

stack_response create() {
    stack_response response;
    stack s = malloc(sizeof(_Stack));
    if (!s) {
        response.code = out_of_memory;
        response.stack = NULL;
        return response;
    }
    s->data = malloc(16 * sizeof(char*));
    if (!s->data) {
        free(s);
        response.code = out_of_memory;
        response.stack = NULL;
        return response;
    }
    s->size = 0;
    s->capacity = 16;
    response.code = success;
    response.stack = s;
    return response;
}

int size(const stack s) {
    return s ? s->size : 0;
}

bool is_empty(const stack s) {
    return s ? s->size == 0 : true;
}

bool is_full(const stack s) {
    return s ? s->size >= MAX_CAPACITY : false;
}

response_code push(stack s, char* item) {
    if (!s || !item) return out_of_memory;
    if (strlen(item) >= MAX_ELEMENT_BYTE_SIZE) {
        return stack_element_too_large;
    }
    if (is_full(s)) {
        return stack_full;
    }
    if (s->size == s->capacity) {
        response_code resize_code = resize_stack(s, s->capacity * 2);
        if (resize_code != success) {
            return resize_code;
        }
    }
    s->data[s->size] = malloc((strlen(item) + 1) * sizeof(char));
    if (!s->data[s->size]) {
        return out_of_memory;
    }
    strcpy(s->data[s->size], item);
    s->size++;
    return success;
}

string_response pop(stack s) {
    string_response response;
    if (!s || s->size == 0) {
        response.code = stack_empty;
        response.string = NULL;
        return response;
    }
    s->size--;
    char* popped_item = s->data[s->size];
    response.code = success;
    response.string = popped_item;
    if (s->size < s->capacity / 4 && s->capacity > 16) {
        resize_stack(s, s->capacity / 2);
    }
    return response;
}

void destroy(stack* s_ptr) {
    if (!s_ptr || !*s_ptr) return;
    stack s = *s_ptr;
    for (int i = 0; i < s->size; i++) {
        free(s->data[i]);
    }
    free(s->data);
    free(s);
    *s_ptr = NULL;
}