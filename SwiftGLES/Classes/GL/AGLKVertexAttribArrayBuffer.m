//
//  AGLKVertexAttribArrayBuffer.m
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/23.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import "AGLKVertexAttribArrayBuffer.h"

@interface AGLKVertexAttribArrayBuffer()

@property (nonatomic, assign) GLuint glName;
@property (nonatomic, assign) GLsizeiptr bufferSizeBytes;
@property (nonatomic, assign) GLsizeiptr stride;
@end

@implementation AGLKVertexAttribArrayBuffer

- (instancetype)initWithAttribStride:(GLsizeiptr)aStride numberOfVertices:(GLsizei)count data:(const GLvoid *)dataPtr usage:(GLenum)usage
{
    NSParameterAssert(0 < aStride);
    NSParameterAssert(0 < count);
    NSParameterAssert(NULL != dataPtr);
    
    if (self == [super init]) {
        self.stride = aStride;
        self.bufferSizeBytes = aStride * count;
        
        glGenBuffers(1, &_glName);
        glBindBuffer(GL_ARRAY_BUFFER, _glName);
        glBufferData(GL_ARRAY_BUFFER, self.bufferSizeBytes, dataPtr, usage);
        
        NSAssert(0 != self.glName, @"Failed to generate glName");
    }
    return self;
}

- (void)prepareToDrawWithAttrib:(GLuint)index numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset shouldEnable:(BOOL)shouldEnable
{
    NSParameterAssert((0 < count) && (count < 4));
    NSParameterAssert(offset < self.stride);
    NSAssert(0 != self.glName, @"Invalid glName");
    
    glBindBuffer(GL_ARRAY_BUFFER, self.glName);
    
    if (shouldEnable) {
        glEnableVertexAttribArray(index);
    }
    
    glVertexAttribPointer(index, count, GL_FLOAT, GL_FALSE, self.stride, NULL + offset);
}

- (void)drawArrayWithMode:(GLenum)mode startVertexIndex:(GLint)first numberOfVertices:(GLsizei)count
{
    glDrawArrays(mode, first, count);
}

- (void)dealloc
{
    if (0 != self.glName) {
        glDeleteBuffers(1, &_glName);
        self.glName = 0;
    }
}

@end
