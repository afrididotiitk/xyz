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
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))
#define USAGE_EXIT(s) do{\
		}while(0);
/*void verification(long long int* a,long long  int num)
{
	for(int i =0;i< num;i++)
	 {
		printf("%lld------",*(a+i));
	 }
	printf("\n---------------------");
}*/
__global__ void calculationkernel(long long int *mem, long long int num,int level)
{
     
     long long  int mod_val = (1 << level);
     long long int i = blockDim.x * blockIdx.x + threadIdx.x;
      if(i >= num || (i%mod_val))
           return;
     long long   int * a = (mem+i);
	 if( i == num -1)
		return;
         if((i+mod_val > num))
         {
           long long int b = *a ^ *(mem+(num-1));
           *a=0;
           *(mem+(num-1))=b;
          return;  
         }
         
      long long int  * b = (a+(mod_val-1));
      long long  int threadNumber = i/mod_val;
      long long  int op=(*a)^(*b);
      if(threadNumber & 1)
      {
         *a=0;
         *b=op;
      }
      else {
          *a = op;
          *b = 0;
      }
    return ;
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    long long int i;
    long long int  *ptr;
    long long int  *sptr;
    long long int  *gpu_mem;    
    unsigned long long  int SEED;		
    unsigned long long int num = NUM;   
    int blocks;

    if(argc == 3){
         num = atoi(argv[1]);   
	  long long    int tmp=atoi(argv[2]);
		if(tmp < 0 || num < 1 )
			{
				printf("Invalid Input");
				exit(-1);
			}		
	SEED=tmp;
    }
	else {
		printf("Usage <# of elements> <SEED value> ");
		exit(-1);
	}	
	
    srand(SEED);
    ptr = (long long int *)malloc(num  * sizeof(long long int));
    sptr = ptr;
	
    for(i=0; i<num; ++i){
	
       *(ptr+i) = random();
    }
    
    gettimeofday(&t_start, NULL);
    
    

    cudaMalloc(&gpu_mem, num * sizeof(long long int));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, num  * sizeof(long long int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    
    gettimeofday(&start, NULL);
    
    blocks = num /1024;
    
    if(num % 1024)
           ++blocks;
    int max_Levels=(int)log(num) + 2 ;
    verification(ptr,num);
    printf("================\n");
    for(int k = 1; k <= max_Levels;k++)
    {
        calculationkernel<<<blocks, 1024>>>(gpu_mem, num,k);
        CUDA_ERROR_EXIT("kernel invocation");
	verification(ptr,num);
}
    gettimeofday(&end, NULL);
    
    /* Copy back result*/

    cudaMemcpy(ptr, gpu_mem, num*sizeof(long long int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);
    
    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);
    sptr = ptr;
    verification(sptr,num); 
	if(num != 1)
	    *sptr = *sptr^*(sptr+num-1);
    printf("final val:\t%lld\n",*sptr);    
    free(ptr);
}
