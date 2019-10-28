#include "pch.h"
#include <iostream>
#include <conio.h>
#include <time.h>

int ackermann(int, int);
int depth;
int calls;
int maxDepth;
int underFlow;
int overFlow;
int numberWindows;
int usedWindows = 2;

void setVariables(int registers) {
numberWindows = registers;
depth = 0;
calls = 0;
maxDepth = 0;
underFlow = 0;
overFlow = 0;
}

int ackermann(int x, int y) {
depth++;
if (depth > maxDepth) {
maxDepth = depth;
}
if (usedWindows == numberWindows) {
overFlow++;
}
else  usedWindows++;

if (x == 0) {
calls = y + 1;
}
else if (y == 0) {
calls = ackermann(x - 1, 1);
}
else {
calls = ackermann(x - 1, ackermann(x, y - 1));
}

depth--;
if (usedWindows == 2) {
underFlow++;
}
else usedWindows--;

return calls;
}

int main()
{
// 6 register set
setVariables(6);
int result = ackermann(3, 6);
printf("Number of Registers = 6, Maximum register window depth = %d,overFlow = %d, underFlow = %d \n", maxDepth, overFlow, underFlow);
//8 register set
setVariables(8);
result = ackermann(3, 6);
printf("Number of Registers = 8, Maximum register window depth = %d,overFlow = %d, underFlow = %d \n",maxDepth, overFlow, underFlow);
//16 register set
setVariables(16);
result = ackermann(3, 6);
printf("Number of Registers = 16, Maximum register window depth = %d,overFlow = %d, underFlow = %d \n", maxDepth, overFlow, underFlow);
return 0;
}
