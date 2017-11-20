#include <metal_stdlib>
using namespace metal;

kernel
void gpu_index_create_kernel(const device uint *input[[ buffer(0) ]],
                             device uint *output[[ buffer(1) ]],
                             uint gid [[ thread_position_in_grid ]]){
};

kernel
void gpu_sort_kernel(const device uint *input[[ buffer(0) ]],
                             device uint *output[[ buffer(1) ]],
                             uint gid [[ thread_position_in_grid ]]){
}
