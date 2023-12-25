#include <stdio.h>

/* (c) Larry Herman, 2023.  You are allowed to use this code yourself, but
   not to provide it to anyone else. */

int m, n, factor, result= -1;

int main() {
  scanf("%d %d %d", &m, &n, &factor);

  if (factor != 0) {
    result= 0;

    while (m <= n) {
      if (m % factor == 0)
        result++;

      m++;
    }
  }

  printf("Result: %d\n", result);

  return 0;
}
