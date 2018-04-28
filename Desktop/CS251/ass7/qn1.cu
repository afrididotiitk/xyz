#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define NUM 10000000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define USAGE_EXIT(s) do{\
      printf("Usage: %s <#of elements> <# of rows> <# of cols> \n %s \n",argv[0],s);\
      exit(-1);\
      }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct num_array{
                    double num1;
                    double num2;
                    double result;
};

//Possibly log n steps

__device__ void function(struct num_array *a)
{
    double square = a ->num1 * a->num1 +  a->num2 * a->num2  + 2 * a->num1 * a->num2;
    a->result = log(square)/sin(square);
    return;
}
__global__ void calculate(char *mem, int num)
{   //TODO: maybe to edit this block.
    //  int i = blockDim.x * blockIdx.x + threadIdx.x;//thread id 
      int i = blockDim.x*blockDim.y*blockIdx.x+blockDim.x*threadIdx.y + threadIdx.x; //XXX
      if(i >= num)
           return;
       struct num_array *a = (struct num_array *)(mem + (i * 3 * sizeof(double)));
      function(a);
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int i;
    struct num_array *pa;
    char *ptr;
    char *sptr;
    char *gpu_mem;   
    unsigned long num = NUM;   /*Default value of num from MACRO*/
    int blocks;
    int row,col;
    if ( argc !=4)
    {
        USAGE_EXIT("Invalid No. of Argument");
    }  
    else 
    {
        num = atoi(argv[1]);
        row = atoi(argv[2]);
        col = atoi(argv[3]);
        if(row <=0 ||col <=0||row*col > 1024)
          USAGE_EXIT("Row/Col number index out of range");
        if(num < 1)
          USAGE_EXIT("Invalid no. of  elements specified.");
    }
    //arguements are fine
    /* Allocate host (CPU) memory and initialize*/
    /* MAX THREADS =  row* col*/
    int gridthread=row*col; //XXX
    ptr = (char *)malloc(num * 3 * sizeof(double));
    sptr = ptr; 
    for(i=0; i<num; ++i){
       pa = (struct num_array *) sptr;
       pa->num1 = (double) i + (double) i * 0.1;
       pa->num2 = pa->num1 + 1.0;
       sptr += 3 * sizeof(double);
    }
    
    
    gettimeofday(&t_start, NULL);
    
    /* Allocate GPU memory and copy from CPU --> GPU*/

    cudaMalloc(&gpu_mem, num * 3 * sizeof(double));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, num * 3 * sizeof(double) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    
    gettimeofday(&start, NULL);
    
    blocks = num /gridthread;
    
    if(num % gridthread)
           ++blocks;
    /*Kernel Invocation*/
    dim3 nThreadsPerBlock(row,col);//XXX
      calculate<<<blocks, nThreadsPerBlock>>>(gpu_mem, num);
    CUDA_ERROR_EXIT("kernel invocation");
    gettimeofday(&end, NULL);
    
    /* Copy back result*/

    cudaMemcpy(ptr, gpu_mem, num * 3 * sizeof(double) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);
    
    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);
    sptr = ptr;
   
    /*Print the last element for sanity check*/ 
    pa = (struct num_array *) (sptr + (num -1)*3*sizeof(double));
    printf("num1=%f num2=%f result=%f\n", pa->num1, pa->num2, pa->result);

    
    free(ptr);
}
