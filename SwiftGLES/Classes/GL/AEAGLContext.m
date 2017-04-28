//
//  AEAGLContext.m
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/23.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import "AEAGLContext.h"

@implementation AEAGLContext

- (void)setClearColor:(GLKVector4)clearColorRGBA
{
    clearColor = clearColorRGBA;
    
    glClearColor(clearColorRGBA.r, clearColorRGBA.g, clearColorRGBA.b, clearColorRGBA.a);
}

- (GLKVector4)clearColor
{
    return clearColor;
}

- (void)clear:(GLbitfield)mask
{
    glClear(mask);
}

@end
