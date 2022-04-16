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
    const size_t num_elements = num_blocks * num_threads_per_block;

    int* arr;
    size_t bytes = num_elements * sizeof(int);
    cudaMallocManaged(&arr, bytes);

    for(size_t i = 0; i < num_elements; i++)   arr[i] = i;

    int device_id;
	cudaGetDevice(&device_id);
    cudaMemPrefetchAsync(arr, bytes, device_id);

	printf("----- GPU -----\n");
    printArray<<<num_blocks, num_threads_per_block>>>(arr, num_elements);
    cudaDeviceSynchronize();

    printf("----- CPU -----\n");
    cudaMemPrefetchAsync(arr, bytes, cudaCpuDeviceId);
    printArrayCPU(arr, num_elements);
}

/* PROFILE

$ nsys profile --stats=true ~/cuda_cpp_tutorial/build/print_array_with_prefetch

----- GPU -----
arr[0] = 0
arr[1] = 1
arr[2] = 2
arr[3] = 3
arr[4] = 4
arr[5] = 5
----- CPU -----
arr[0] = 0
arr[1] = 1
arr[2] = 2
arr[3] = 3
arr[4] = 4
arr[5] = 5
Generating '/tmp/nsys-report-d472.qdstrm'
[1/8] [========================100%] report1.nsys-rep
[2/8] [========================100%] report1.sqlite
[3/8] Executing 'nvtxsum' stats report
SKIPPED: /root/cuda_cpp_tutorial/build/report1.sqlite does not contain NV Tools Extension (NVTX) data.
[4/8] Executing 'osrtsum' stats report

Operating System Runtime API Statistics:

 Time (%)  Total Time (ns)  Num Calls   Avg (ns)    Med (ns)   Min (ns)  Max (ns)  StdDev (ns)       Name     
 --------  ---------------  ---------  ----------  ----------  --------  --------  -----------  --------------
     70.2        231463209         17  13615482.9  10060535.0      3250  68769206   17963544.0  poll          
     14.2         46707197        454    102879.3     11345.0      1010  13064068     743131.1  ioctl         
      9.6         31819233         13   2447633.3     26640.0     10670  20429791    6081350.0  sem_timedwait 
      5.5         18114990         30    603833.0      3790.0      1210  17910430    3268710.9  fopen         
      0.2           752665         27     27876.5      3110.0      2150    466242      88468.7  mmap64        
      0.1           389781         44      8858.7      8125.5      3300     25340       4368.9  open64        
      0.1           176071          5     35214.2     42150.0     18800     45871      11728.4  pthread_create
      0.0           111910         18      6217.2      5510.0      1270     28480       6326.0  mmap          
      0.0            41450          1     41450.0     41450.0     41450     41450          0.0  fgets         
      0.0            32010          6      5335.0      5040.0      2450      7900       2152.6  open          
      0.0            24480          7      3497.1      3190.0      2390      5690       1155.1  munmap        
      0.0            23310         11      2119.1      2250.0      1090      3960        893.8  write         
      0.0            20590          9      2287.8      1250.0      1070      6800       2079.4  fcntl         
      0.0            19100          9      2122.2      1710.0      1080      3980       1060.0  fclose        
      0.0            17040          8      2130.0      1935.0      1350      3320        663.7  read          
      0.0            15720          2      7860.0      7860.0      3500     12220       6166.0  socket        
      0.0            13250          2      6625.0      6625.0      5820      7430       1138.4  fread         
      0.0            11230          2      5615.0      5615.0      1420      9810       5932.6  fwrite        
      0.0             9390          1      9390.0      9390.0      9390      9390          0.0  connect       
      0.0             8610          2      4305.0      4305.0      1040      7570       4617.4  fflush        
      0.0             7480          1      7480.0      7480.0      7480      7480          0.0  pipe2         
      0.0             2380          1      2380.0      2380.0      2380      2380          0.0  bind          

[5/8] Executing 'cudaapisum' stats report

CUDA API Statistics:

 Time (%)  Total Time (ns)  Num Calls   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)          Name         
 --------  ---------------  ---------  -----------  -----------  ---------  ---------  -----------  ---------------------
     99.8        190180906          1  190180906.0  190180906.0  190180906  190180906          0.0  cudaMallocManaged    
      0.1           216510          2     108255.0     108255.0      21790     194720     122280.0  cudaMemPrefetchAsync 
      0.0            56570          1      56570.0      56570.0      56570      56570          0.0  cudaDeviceSynchronize
      0.0            46641          1      46641.0      46641.0      46641      46641          0.0  cudaLaunchKernel     

[6/8] Executing 'gpukernsum' stats report

CUDA Kernel Statistics:

 Time (%)  Total Time (ns)  Instances  Avg (ns)  Med (ns)  Min (ns)  Max (ns)  StdDev (ns)                Name              
 --------  ---------------  ---------  --------  --------  --------  --------  -----------  --------------------------------
    100.0            43168          1   43168.0   43168.0     43168     43168          0.0  printArray(int *, unsigned long)

[7/8] Executing 'gpumemtimesum' stats report

CUDA Memory Operation Statistics (by time):

 Time (%)  Total Time (ns)  Count  Avg (ns)  Med (ns)  Min (ns)  Max (ns)  StdDev (ns)              Operation            
 --------  ---------------  -----  --------  --------  --------  --------  -----------  ---------------------------------
     61.1             1856      1    1856.0    1856.0      1856      1856          0.0  [CUDA Unified Memory memcpy HtoD]
     38.9             1184      1    1184.0    1184.0      1184      1184          0.0  [CUDA Unified Memory memcpy DtoH]

[8/8] Executing 'gpumemsizesum' stats report

CUDA Memory Operation Statistics (by size):

 Total (MB)  Count  Avg (MB)  Med (MB)  Min (MB)  Max (MB)  StdDev (MB)              Operation            
 ----------  -----  --------  --------  --------  --------  -----------  ---------------------------------
      0.004      1     0.004     0.004     0.004     0.004        0.000  [CUDA Unified Memory memcpy DtoH]
      0.004      1     0.004     0.004     0.004     0.004        0.000  [CUDA Unified Memory memcpy HtoD]

Generated:
    /root/cuda_cpp_tutorial/build/report1.nsys-rep
    /root/cuda_cpp_tutorial/build/report1.sqlite

*/