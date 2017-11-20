import Metal
import MetalKit


let device = MTLCreateSystemDefaultDevice()!
let queue = device.makeCommandQueue()!
let library = device.makeDefaultLibrary()!
let gpuIndexCreateKernel = library.makeFunction(name: "gpu_index_create_kernel")!
let gpuSortKernel = library.makeFunction(name: "gpu_sort_kernel")!

func gpuSort(rids: inout [UInt], values: inout [UInt]) {
    let pipelineState = try! device.makeComputePipelineState(function: gpuSortKernel)
    guard let commandBuffer = queue.makeCommandBuffer() else { fatalError() }
    guard let encoder = commandBuffer.makeComputeCommandEncoder() else { fatalError() }

    let length = values.count * MemoryLayout<UInt>.size
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
}

func gpuIndexCreate(values: inout [UInt]) -> [UInt] {
    var rids = [UInt](repeating: 0, count: values.count)
    for i in 0 ..< rids.count { rids[i] = UInt(i) }
    gpuSort(rids: &rids, values: &values)
    return [UInt](repeating: 0, count: 1)
}

let count = 128
var vector = [UInt](repeating: 0, count: count)
for i in 0 ..< vector.count {
    vector[i] = UInt(i)
}
let result = gpuIndexCreate(values: &vector)

