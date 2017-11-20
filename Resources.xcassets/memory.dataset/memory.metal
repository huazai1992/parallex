#include <metal_stdlib>
using namespace metal;

kernel void compute(const device float *inVector [[ buffer(0) ]],
                    device float *outVector [[ buffer(1) ]],
                    uint id [[ thread_position_in_grid ]])
{
    outVector[id] = 1.0 / (1.0 + exp(-inVector[id]));
}


kernel
void vec_mul(const device float *aVector [[ buffer(0) ]],
                    const device float *bVector [[ buffer(1) ]],
                    device float *cVector [[buffer(2)]],
                    uint id [[ thread_position_in_grid ]])
{
    cVector[id] = aVector[id]*bVector[id];
}
