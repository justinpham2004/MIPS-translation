#include <stdio.h>

/* (c) Larry Herman, 2023.  You are allowed to use this code yourself, but
   not to provide it to anyone else. */

int m, n, factor, temp;

static int num_multiples(int value1, int value2, int number);

static int num_multiples(int value1, int value2, int number) {
  int result;

  result= -1;

  if (number != 0) {
    result= 0;

    while (value1 <= value2) {
      if (value1 % number == 0)
        result++;

      value1++;
    }
  }

  return result;
}

int main() {
  scanf("%d %d %d", &m, &n, &factor);

  temp= num_multiples(m, n, factor);
  printf("Result: %d\n", temp);

  return 0;
}
