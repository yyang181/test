/******************************************************************************
 *cr
 *cr            (C) Copyright 2010 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ******************************************************************************/

#include <stdio.h>
#include <math.h>

    
__global__ void VecAdd(int n, const float *A, const float *B, float* C) {

    /********************************************************************
     *
     * Compute C = A + B
     *   where A is a (1 * n) vector
     *   where B is a (1 * n) vector
     *   where C is a (1 * n) vector
     *
     ********************************************************************/

    // INSERT KERNEL CODE HERE

	int i = blockIdx.x*blockDim.x + threadIdx.x;

	 C[i] = A[i] + B[i];
}


void basicVecAdd( float *A,  float *B, float *C, int n)
{

    // Initialize thread block and kernel grid dimensions ---------------------

    const unsigned int BLOCK_SIZE = 256; 

    //INSERT CODE HERE
        dim3 dim_grid, dim_block;
	dim_grid = (n + BLOCK_SIZE -1)/BLOCK_SIZE;  
	dim_block = 256 ;
	VecAdd<<<dim_grid, dim_block>>>(n, A, B, C);

}
