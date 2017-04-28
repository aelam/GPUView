//
//  AGLKTextureInfo.h
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/24.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface AGLKTextureInfo : NSObject

@property (nonatomic, assign, readonly) GLuint name;
@property (nonatomic, assign, readonly) GLenum target;
@property (nonatomic, assign, readonly) GLuint width;
@property (nonatomic, assign, readonly) GLuint height;

@end

@interface AGLKTextureLoader : NSObject

+ (AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage options:(NSDictionary *)options error:(NSError **)error;
@end
