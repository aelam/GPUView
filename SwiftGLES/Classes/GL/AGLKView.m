//
//  AGLKView.m
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/23.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import "AGLKView.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface AGLKView ()

@property (nonatomic, assign) GLuint colorRenderBuffer;
@property (nonatomic, assign) GLuint depthRenderBuffer;
@property (nonatomic, assign) GLuint defaultFrameBuffer;

@end


@implementation AGLKView

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)context {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        self.context = context;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
    // kEAGLDrawablePropertyRetainedBacking告诉CoreAnimation层不保留以前绘制的图像留作以后重用
    // kEAGLDrawablePropertyColorFormat告诉CoreAnimation层用8位来保留每个像素中每个分量的颜色的值。
    eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
}

- (void)drawRect:(CGRect)rect {
    if (_enableSetNeedsDisplay) {
        [self display];
    }
    
}

- (void)display {
    [EAGLContext setCurrentContext:self.context];
    glViewport(0, 0, (GLsizei)self.drawableWidth, (GLsizei)self.drawableHeight);

    if (_delegate)
    {
        [_delegate glkView:self drawInRect:self.bounds];
    }

    [self.context presentRenderbuffer:GL_RENDERBUFFER];
    
    
}


/**
 由于改变了层的大小，需要重新创建深度缓存，像素颜色渲染缓存会自动调整大小
 */
- (void)layoutSubviews {
    CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
    
    // 层的尺寸发生改变，调整视图的缓存的尺寸以匹配层的新尺寸
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:eaglLayer];
    
    
    if (0 != _depthRenderBuffer) {
        glDeleteRenderbuffers(1, &_depthRenderBuffer);
        _depthRenderBuffer = 0;
    }
    
    GLint currentDrawableWidth = (GLint)self.drawableWidth;
    GLint currentDrawableHeight = (GLint)self.drawableHeight;
    
    if (self.drawableDepthFormat != GLKViewDrawableDepthFormatNone && 0 < currentDrawableWidth && 0 < currentDrawableHeight) {
        // 生成一个深度缓存标识符
        glGenRenderbuffers(1, &_depthRenderBuffer);
        // 告诉OpenGLES在接下来的操作中使用深度缓存
        glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
        // 配置：指定深度缓存的大小
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, currentDrawableWidth, currentDrawableHeight);
        // 把深度缓存添加到帧缓存中
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);

    }
    
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    
    if (status != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"failed to make complete frame buffer object %x",status);
    }

    // Make the Color Render Buffer the current buffer for display
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);

}

- (void)setContext:(EAGLContext *)aContext
{
    if (_context != aContext) {
        _context = aContext;
    }
    
    if (_context == nil) {
        return;
    }
    
    [EAGLContext setCurrentContext:_context];
    
    // _defaultFrameBuffer
    if (0 != _defaultFrameBuffer)
    {
        glDeleteFramebuffers(1, &_defaultFrameBuffer); // Step 7
        _defaultFrameBuffer = 0;
    }
    
    glGenFramebuffers(1, &_defaultFrameBuffer);    // Step 1
    glBindFramebuffer(GL_FRAMEBUFFER, _defaultFrameBuffer);
    
    
    // _depthRenderBuffer
    if (_depthRenderBuffer != 0) {
        glDeleteFramebuffers(1, &_depthRenderBuffer);
        _depthRenderBuffer = 0;
    }
    
    glGenFramebuffers(1, &_depthRenderBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _depthRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
    
    // _colorRenderBuffer
    if (_colorRenderBuffer != 0) {
        glDeleteRenderbuffers(1, &_colorRenderBuffer);
        _colorRenderBuffer = 0;
    }
    
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
}


/**
 获取当前上下文的帧缓存像素颜色渲染缓存的尺寸
 */
- (NSInteger)drawableWidth {
    GLint renderBufferWidth;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &renderBufferWidth);
    return (NSInteger)renderBufferWidth;
}

/**
 获取当前上下文的帧缓存像素颜色渲染缓存的尺寸
 */
- (NSInteger)drawableHeight {
    GLint renderBufferHeight;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &renderBufferHeight);
    return (NSInteger)renderBufferHeight;
}


/*
 Binds the context and drawable. This needs to be called when the currently bound framebuffer
 has been changed during the draw method.
 */
- (void)bindDrawable {
    
}

/*
 deleteDrawable is normally invoked by the GLKViewController when an application is backgrounded, etc.
 It is the responsibility of the developer to call deleteDrawable when a GLKViewController isn't being used.
 */
- (void)deleteDrawable {
    
}


- (void)dealloc {
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}

@end
