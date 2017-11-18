#include <metal_stdlib>
using namespace metal;

kernel
void vec_mul(const device float *aVector [[ buffer(0) ]],
                    const device float *bVector [[ buffer(1) ]],
                    device float *cVector [[buffer(2)]],
                    uint id [[ thread_position_in_grid ]]){
    cVector[id] = aVector[id]*bVector[id];
}

struct PentaxUnit{
    uint src_ip;
    uint dst_ip;
    ushort src_port;
    ushort dst_port;
    ushort protocol_type;
}

kernel
void sort(device uint *src_ip[[buffer(0)]],
          device uint *dst_ip[[buffer(1)]],
          device uint *src_port[[buffer(2)]],
          device uint *dst_port[[buffer(3)]],
          device uint *protocol_type[[buffer(4)]],
          uint gid [[thread_position_in_grid]]){
    
    
    
}


kernel
void gpu_index_create_kernel(constant device uint *input[[ buffer(0) ]]
                             device uint *output[[ buffer(1) ]]
                             uint id [[ thread_position_in_grid ]]){
}

kernel
void gpu_sort_kernel(constant device uint *input[[ buffer(0) ]]
                             device uint *output[[ buffer(1) ]]
                             uint id [[ thread_position_in_grid ]]){
}
//
//kernel
//void parallel_bitonic(device int *input [[buffer(0)]],
//                            constant int &p [[buffer(1)]],
//                            constant int &q [[buffer(2)]],
//                            uint gid [[thread_position_in_grid]]){
//    int distance = 1 << (p-q);
//    bool direction = ((gid >> p) & 2) == 0;
//    
//    if ((gid & distance) == 0 && (input[gid] > input[gid | distance]) == direction) {
//        DataType temp = input[gid];
//        input[gid] = input[gid | distance];
//        input[gid | distance] = temp;
//    }
//}

