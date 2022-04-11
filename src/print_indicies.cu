#include <stdio.h>

__global__ void printIndicies()
{
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	printf("index = %d\n", index);
}

int main()
{
    printIndicies<<<2, 3>>>();
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