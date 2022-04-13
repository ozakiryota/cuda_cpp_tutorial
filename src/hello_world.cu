#include <stdio.h>

__global__ void helloWorld()
{
    printf("Hello World!\n");
}

int main()
{
    size_t num_blocks = 1;
    size_t num_threads_per_block = 3;

    helloWorld<<<num_blocks, num_threads_per_block>>>();
    cudaDeviceSynchronize();
}

/* OUTPUT

Hello World!
Hello World!
Hello World!

*/