#include <stdio.h>

__global__ void helloWorld()
{
    printf("Hello World!\n");
}

int main()
{
    int device_id;
    cudaGetDevice(&device_id);

    cudaDeviceProp props;
    cudaGetDeviceProperties(&props, device_id);

    printf("Device ID: %d\n", device_id);
    printf("Number of SMs: %d\n", props.multiProcessorCount);
    printf("Compute Capability Major: %d\n", props.major);
    printf("Compute Capability Minor: %d\n", props.minor);
    printf("Warp Size: %d\n", props.warpSize);
}

/* OUTPUT

Device ID: 0
Number of SMs: 28
Compute Capability Major: 8
Compute Capability Minor: 6
Warp Size: 32

*/