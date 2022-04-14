#include <stdio.h>

__global__ void printIndicies()
{
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	printf("index = %d\n", index);
}

int main()
{
    const size_t num_blocks = 2;
    const size_t num_threads_per_block = 3;

    printIndicies<<<num_blocks, num_threads_per_block>>>();
    cudaDeviceSynchronize();
}

/* OUTPUT

index = 0
index = 1
index = 2
index = 3
index = 4
index = 5

*/