#include <stdio.h>

__global__ void helloWorld()
{
    printf("Hello World!\n");
}

int main()
{
    helloWorld<<<1, 3>>>();
    cudaDeviceSynchronize();
}

/* OUTPUT

Hello World!
Hello World!
Hello World!

*/