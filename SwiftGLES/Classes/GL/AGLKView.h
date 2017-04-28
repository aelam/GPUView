//
//  AGLKView.h
//  OpenGLES-0-重新实现GLKView
//
//  Created by 黄强强 on 17/3/23.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@protocol AGLKViewDelegate;

@interface AGLKView : UIView

@property (nonatomic, weak) id<AGLKViewDelegate> delegate;
@property (nonatomic, strong) EAGLContext *context;

@property (nonatomic, assign) NSInteger drawableWidth;
@property (nonatomic, assign) NSInteger drawableHeight;
@property (nonatomic) BOOL enableSetNeedsDisplay;


- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)context;

@property (nonatomic) GLKViewDrawableColorFormat drawableColorFormat;
@property (nonatomic) GLKViewDrawableDepthFormat drawableDepthFormat;
@property (nonatomic) GLKViewDrawableStencilFormat drawableStencilFormat;
@property (nonatomic) GLKViewDrawableMultisample drawableMultisample;


- (void)display;

/*
 Binds the context and drawable. This needs to be called when the currently bound framebuffer
 has been changed during the draw method.
 */
- (void)bindDrawable;

/*
 deleteDrawable is normally invoked by the GLKViewController when an application is backgrounded, etc.
 It is the responsibility of the developer to call deleteDrawable when a GLKViewController isn't being used.
 */
- (void)deleteDrawable;

@end


@protocol AGLKViewDelegate <NSObject>
- (void)glkView:(AGLKView *)view drawInRect:(CGRect)rect;
@end
