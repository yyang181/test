/******************************************************************************
 *cr
 *cr            (C) Copyright 2010 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ******************************************************************************/

// Define your kernels in this file you may use more than one kernel if you
// need to

// INSERT KERNEL(S) HERE
#include <stdio.h>

#include <device_functions.h>

#include <stdlib.h>

#include <inttypes.h>

// #include "sm_50_atomic_functions.h"

#include <cuda_runtime.h>  

#define BLOCK_SIZE 1024

__global__ void histo_kernel(unsigned int* input, unsigned int* bins, unsigned int num_elements,
                             unsigned int num_bins)
{
  // initialize shared histo

  extern  __shared__ unsigned int private_histo[];

  // __shared__ unsigned int private_histo[16384];

  int tx = threadIdx.x; 

  int i = threadIdx.x + blockIdx.x * blockDim.x;

  // if (tx < BLOCK_SIZE)
  //     for(unsigned int j = 0; j < num_bins; ++j) {
  //      private_histo[j] = 0;
  //     }
  // }
  for (int p = 0; p < (BLOCK_SIZE+num_bins-1)/BLOCK_SIZE; p++) {
    if ( p * tx < num_bins){
      private_histo[ p*tx] = 0;
    }
  }

    // if (tx < num_bins) private_histo[tx] = 0;

  __syncthreads();

  // stride is total number of threads
  int stride = blockDim.x * gridDim.x;

  // All threads handle blockDim.x * gridDim.x
  // consecutive elements
  while (i < num_elements) {
    atomicAdd( &(private_histo[input[i]]), 1);
    i += stride;
  }

        // wait for all other threads in the block to finish
        __syncthreads();

  for (int q = 0; q < (BLOCK_SIZE+num_bins-1)/BLOCK_SIZE; q++) {
    if ( q * BLOCK_SIZE + tx < num_bins &&  threadIdx.x < BLOCK_SIZE) {
        atomicAdd(&(bins[q*BLOCK_SIZE+threadIdx.x]), private_histo[q*BLOCK_SIZE+threadIdx.x] );
    }
  }


      // if (threadIdx.x < BLOCK_SIZE) {
      //   atomicAdd(&(bins[threadIdx.x]), private_histo[threadIdx.x] );
      // }
}



/******************************************************************************
Setup and invoke your kernel(s) in this function. You may also allocate more
GPU memory if you need to
*******************************************************************************/
void histogram(unsigned int* input, unsigned int* bins, unsigned int num_elements,
        unsigned int num_bins) {

    // INSERT CODE HERE

    // dim3 dim_grid((num_elements+BLOCK_SIZE-1)/BLOCK_SIZE);

  // const unsigned int num_bins;

  dim3 dim_grid(16,1);

  // dim3 dim_grid(BLOCK_SIZE,1);

  dim3 dim_block(BLOCK_SIZE,1);

	histo_kernel<<<dim_grid, dim_block, num_bins * sizeof(unsigned int)>>>( input, bins, num_elements, num_bins);

}


