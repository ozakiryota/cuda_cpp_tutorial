#include <stdio.h>

__global__ void printArray(int* arr, size_t num_elements)
{
	int index = threadIdx.x + blockIdx.x * blockDim.x;
    int grid_stride = gridDim.x * blockDim.x;

    for(int i = index; i < num_elements; i += grid_stride){
	    printf("arr[%d] = %d\n", i, arr[i]);
    }
}

int main()
{
    const size_t num_blocks = 2;
    const size_t num_threads_per_block = 3;
    const size_t num_elements = 10;

    int* arr;
    size_t bytes = num_elements * sizeof(int);
    cudaMallocManaged(&arr, bytes);

    for(size_t i = 0; i < num_elements; i++)   arr[i] = i;

    printArray<<<num_blocks, num_threads_per_block>>>(arr, num_elements);
    cudaDeviceSynchronize();
}

/* OUTPUT

arr[0] = 0
arr[1] = 1
arr[2] = 2
arr[3] = 3
arr[4] = 4
arr[5] = 5
arr[6] = 6
arr[7] = 7
arr[8] = 8
arr[9] = 9

*/