import Metal
import MetalKit


guard let device = MTLCreateSystemDefaultDevice() else {
    fatalError()
}
guard let queue = device.makeCommandQueue() else {
    fatalError()
}
guard let library = device.makeDefaultLibrary() else {
    fatalError("Can not find metal lib")
}
guard let vecMul = library.makeFunction(name: "vec_mul") else {
    fatalError("Can not make function vec_mul")
}
guard let gpuIndexCreateKernel = library.makeFunction(name: "gpu_index_create_kernel") else {
    fatalError("Can not make function gpu_index_create_kernel")
}
guard let gpuSortKernel = library.makeFunction(name: "gpu_sort_kernel") else {
    fatalError("Can not make function gpu_sort_kernel")
}

func gpuGeneralComputeInit(kernel: MTLFunction) -> (MTLComputePipelineState, MTLCommandBuffer, MTLComputeCommandEncoder) {
    let pipelineState = try! device.makeComputePipelineState(function: gpuIndexCreateKernel)
    guard let commandBuffer = queue.makeCommandBuffer() else {
        fatalError()
    }
    guard let encoder = commandBuffer.makeComputeCommandEncoder() else {
        fatalError()
    }
    return (pipelineState, commandBuffer, encoder)
}

func gpuSort(rids: inout [UInt], values: inout [UInt]) {

}

func gpuIndexCreate(values: [UInt]) -> [UInt8] {
    let (pipelineState, commandBuffer, encoder) = gpuGeneralComputeInit(kernel: gpuIndexCreateKernel)

    let length = values.capacity * MemoryLayout<UInt>.size
    let inBuffer = device.makeBuffer(bytes: values, length: length, options: [])
    guard let outBuffer = device.makeBuffer(length: length, options: []) else {
        fatalError("Can not create out buffer")
    }

    encoder.setComputePipelineState(pipelineState)
    encoder.setBuffer(inBuffer, offset: 0, index: 0)
    encoder.setBuffer(outBuffer, offset: 0, index: 1)

    let threadsPerThreadGroup = 128
    let size = MTLSize(width: values.capacity, height: 1, depth: 1)
    let groupSize = MTLSize(width: threadsPerThreadGroup, height: 1, depth: 1)

    encoder.dispatchThreadgroups(size, threadsPerThreadgroup: groupSize)
    encoder.endEncoding()
    commandBuffer.commit()
    commandBuffer.waitUntilCompleted()

    let result = outBuffer.contents().bindMemory(to: Float.self, capacity: count)
    var data = [Float](repeating: 0, count: count)
    memcpy(&data, result, length)
    // TODO
    return [UInt8]()
}

let count = 128
var vector = [UInt](repeating: 0, count: count)
for i in 0..<vector.capacity {
    vector[i] = UInt(i)
}
let result = gpuIndexCreate(values: vector)
print(result[0])

