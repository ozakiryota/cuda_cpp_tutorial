#include <stdio.h>

__global__ void hoge()
{
    int hoge = 1 + 1;
}

int main()
{
    /*device query*/
	int device_id;
	cudaGetDevice(&device_id);
	int num_sm;
	cudaDeviceGetAttribute(&num_sm, cudaDevAttrMultiProcessorCount, device_id);

    printf("num_sm = %d\n", num_sm);

    /*Grid sizes that are multiples of the number of available SMs can increase performance*/
    const size_t num_blocks = 32 * num_sm;
    const size_t num_threads_per_block = 256;

    hoge<<<num_blocks, num_threads_per_block>>>();
    cudaDeviceSynchronize();
}

/* OUTPUT

num_sm = 28

*/