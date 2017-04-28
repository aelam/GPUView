//
//  AGLKVertexAttribArrayBuffer.h
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/23.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface AGLKVertexAttribArrayBuffer : NSObject

@property (nonatomic, assign, readonly) GLuint glName;
@property (nonatomic, assign, readonly) GLsizeiptr bufferSizeBytes;
@property (nonatomic, assign, readonly) GLsizeiptr stride;

- (instancetype)initWithAttribStride:(GLsizeiptr)stride numberOfVertices:(GLsizei)count data:(const GLvoid *)dataPtr usage:(GLenum)usage;

- (void)prepareToDrawWithAttrib:(GLuint)index numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset shouldEnable:(BOOL)shouldEnable;

- (void)drawArrayWithMode:(GLenum)mode startVertexIndex:(GLint)first numberOfVertices:(GLsizei)count;

@end
