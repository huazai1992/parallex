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

kernel
void gpu_produce_chunk_id_literals(const device uint *rid[[ buffer(0) ]],
                                   device uint *lit[[ buffer(1) ]],
                                   device uint *chIds[[ buffer(2) ]],
                                   uint gid [[ thread_position_in_grid ]]){
    lit[gid] = 0x1 << (rid[gid] % 31);
    lit[gid] |= 0x1 << 31;
    chIds[gid] = rid[gid] / 31;
}
