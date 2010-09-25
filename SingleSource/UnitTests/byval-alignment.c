#include <stdio.h>

#if defined(_MSC_VER) && !defined(__clang__)
# define no_inline __declspec(noinline)
#else
# define no_inline __attribute__((noinline))
#endif

struct s0 {
  long double x, y;
};

struct s0 g0;

no_inline void f0(int i, struct s0 y);
void f0(int i, struct s0 y) {
  g0 = y;
  g0.x += i;
  g0.y += i;
}

int main() {
  struct s0 a = { 1., 2. };
  f0(1, a);
  printf("g0.x: %.4f, g0.y: %.4f\n", (double) g0.x, (double) g0.y);
  return 0;
}
