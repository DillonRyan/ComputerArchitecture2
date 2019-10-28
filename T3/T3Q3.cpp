#include "pch.h"
#include <time.h>
#include <stdio.h>


int ackermann(int x, int y) {
if (x == 0) {
return y + 1;
}
else if (y == 0) {
return ackermann(x - 1, 1);
}
else {
return ackermann(x - 1, ackermann(x, y - 1));
}
}

int main() {
int i = 0;
time_t start = clock();
for (; i < 1; i++) {
ackermann(3, 6);
}
time_t elapsed = clock() - start;
long ns = elapsed * 1000 * 1000 / (CLOCKS_PER_SEC);
long timeToRunOne = ns / 10000;
printf("Time to calculate Ackermann(3,6) on my computer : %ld ns\n", timeToRunOne);
return 0;
}
 
