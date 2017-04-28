//
//  AGLKTextureInfo.m
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/24.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import "AGLKTextureLoader.h"

size_t AGLKCalculatePowerOf2ForDimension(size_t originalWidth)
{
    return 0;
}

static NSData * AGLKDataWithResizedCGImageBytes(CGImageRef cgImage,size_t *widthPtr, size_t *heightPtr)
{
    size_t originalWidth = CGImageGetWidth(cgImage);
    size_t originalHeight = CGImageGetHeight(cgImage);
    
    size_t width = AGLKCalculatePowerOf2ForDimension(originalWidth);
    size_t height = AGLKCalculatePowerOf2ForDimension(originalHeight);
    
    NSMutableData *imageData = [NSMutableData dataWithLength:width * height * 4]; // RGBA占用4bit
    NSCAssert(nil != imageData, @"Unable to allocate image storage.");
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef cgContext = CGBitmapContextCreate([imageData mutableBytes], width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    // 翻转和缩放图像，因为CoreGraphics的坐标和OpenGLES的坐标不一样
    CGContextTranslateCTM(cgContext, 0, height);
    CGContextScaleCTM(cgContext, 1.0, -1.0);
    
    CGContextDrawImage(cgContext, CGRectMake(0, 0, width, height), cgImage);
    
    CGContextRelease(cgContext);
    
    *widthPtr = width;
    *heightPtr = height;
    return imageData;
}

@interface AGLKTextureInfo()
@property (nonatomic, assign) GLuint name;
@property (nonatomic, assign) GLenum target;
@property (nonatomic, assign) GLuint width;
@property (nonatomic, assign) GLuint height;
@end

@implementation AGLKTextureInfo


@end

@implementation AGLKTextureLoader

+ (AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage options:(NSDictionary *)options error:(NSError *__autoreleasing *)error
{
    size_t width;
    size_t height;
    NSData *imageData = AGLKDataWithResizedCGImageBytes(cgImage,&width,&height);
    GLuint textureID;
    glGenTextures(1, &textureID);
    glBindTexture(GL_TEXTURE_2D, textureID);
    
    
    /**
     glTexImage2D函数是OpenGLES标准中最复杂的函数之一。
     复制图片像素数据到绑定的纹理缓存中。

     第一个参数： GL_TEXTURE_2D 用于2D纹理
     第二个参数： 用于指定MIP贴图的初始细节级别，如果没有使用MIP贴图，则填0，如果开启了MIP贴图，自行查阅相关文档
     第三个参数： 指定纹理缓存内每个纹素需要保存的颜色信息格式
     第四、五个参数：指定图像的高度和宽度，需要是2的幂。
     第六个参数： border参数一直是用来确定围绕纹理的纹素的一个边界大小，在OpenGLES中总为0
     第七个参数： 指定初始化缓存所用的图像数据中每个像素所要保存的信息。
     第八个参数： 指定所要保存的纹素数据的位编码类型。（GL_UNSIGNED_BYTE、GL_UNSIGNED_SHORT_5_6_5、GL_UNSIGNED_SHORT_4_4_4_4、GL_UNSIGNED_SHORT_5_5_5_1）。类型后面的5_6_5,4_4_4是说明比如总共存在2个字节里面，第一个5个说明头5个bit存红色分量数据，接下来6比特存绿色分量数据，接下来5比特存蓝色分量数据，总共为2字节。GL_UNSIGNED_BYTE类型色彩质量最佳。
     第九个参数： 指定初始化缓存所用的图像数据，此数据格式应该与第三个参数一致。
     */
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_SHORT_5_5_5_1, [imageData bytes]);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    AGLKTextureInfo *info = [[AGLKTextureInfo alloc] init];
    info.name = textureID;
    info.target = GL_TEXTURE_2D;
    info.width = (GLint)width;
    info.height = (GLint)height;
    return info;
}

@end
