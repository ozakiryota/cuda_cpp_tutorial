#include <stdio.h>

void printArrayCPU(int* arr, size_t num_elements)
{
    for(size_t i = 0; i < num_elements; i++){
	    printf("arr[%d] = %d\n", i, arr[i]);
    }
}

__global__ void printArray(int* arr, size_t num_elements)
{
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	printf("arr[%d] = %d\n", index, arr[index]);
}

int main()
{
    const size_t num_blocks = 2;
    const size_t num_threads_per_block = 3;
    size_t num_elements = num_blocks * num_threads_per_block;

    int* arr;
    size_t bytes = num_elements * sizeof(int);
    arr = (int *)malloc(bytes);
    
    for(size_t i = 0; i < num_elements; i++)   arr[i] = i;

	printf("----- CPU -----\n");
    printArrayCPU(arr, num_elements);

	printf("----- GPU -----\n");
    printArray<<<num_blocks, num_threads_per_block>>>(arr, num_elements);
    cudaDeviceSynchronize();
}

/* OUTPUT

----- CPU -----
arr[0] = 0
arr[1] = 1
arr[2] = 2
arr[3] = 3
arr[4] = 4
arr[5] = 5
----- GPU -----

*/