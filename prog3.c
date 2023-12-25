#include <stdio.h>

/* (c) Larry Herman, 2023.  You are allowed to use this code yourself, but
   not to provide it to anyone else. */

int m, n, factor, temp;

static int num_mult_helper(int val1, int val2, int number, int cur_result);
static int num_mult(int value1, int value2, int number);

static int num_mult_helper(int val1, int val2, int num, int cur_result) {
  int result, next_value;

  result= -1;

  if (num != 0) {
    if (val1 > val2)
      result= cur_result;
    else {
      next_value= val1 + 1;
      result= num_mult_helper(next_value, val2, num, cur_result);
      if (val1 % num == 0)
        result++;
    }
  }

  return result;
}

static int num_mult(int value1, int value2, int number) {
  return num_mult_helper(value1, value2, number, 0);
}

int main() {
  scanf("%d %d %d", &m, &n, &factor);

  temp= num_mult(m, n, factor);
  printf("Result: %d\n", temp);

  return 0;
}
