#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AEAGLContext.h"
#import "AGLKTextureLoader.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "AGLKView.h"
#import "SwiftGL.h"
#import "GPUView.h"

FOUNDATION_EXPORT double SwiftGLESVersionNumber;
FOUNDATION_EXPORT const unsigned char SwiftGLESVersionString[];

