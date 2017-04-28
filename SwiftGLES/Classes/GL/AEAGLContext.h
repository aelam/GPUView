//
//  AEAGLContext.h
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/23.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface AEAGLContext : EAGLContext
{
    GLKVector4 clearColor;
}
@property (nonatomic, assign) GLKVector4 clearColor;

- (void)clear:(GLbitfield)mask;
@end
