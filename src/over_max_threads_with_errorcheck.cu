#include <stdio.h>

__global__ void printIndicies()
{
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	printf("index = %d\n", index);
}

int main()
{
    const size_t num_blocks = 1;
    const size_t num_threads_per_block = 1025; // > 1024

    printIndicies<<<num_blocks, num_threads_per_block>>>();
    cudaDeviceSynchronize();

    cudaError_t err = cudaGetLastError();
    if(err != cudaSuccess)  printf("Error: %s\n", cudaGetErrorString(err));
}

/* OUTPUT

Error: invalid configuration argument

*/