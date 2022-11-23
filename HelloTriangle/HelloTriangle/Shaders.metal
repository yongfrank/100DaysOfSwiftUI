//
//  Shaders.metal
//  HelloTriangle
//
//  Created by Frank Chu on 10/1/22.
//

#include <metal_stdlib>
using namespace metal;

#include "definitions.h"

struct Fragment {
    float4 position [[position]];
    float4 color;
};


vertex Fragment vertexShader(const device Vertex *vertexArray [[buffer(0)]], unsigned int vid [[vertex_id]]) {
    
    /*
     struct Vertex
     
     unsigned int vid [[vertex_id]]
     */
    Vertex input = vertexArray[vid];
    
    /*
     struct Fragment
     */
    Fragment output;
    output.position = float4(input.position.x, input.position.y, 0, 1);
    output.color = input.color;
    
    return output;
}

fragment float4 fragmentShader(Fragment input [[stage_in]]) {
    return input.color;
}
