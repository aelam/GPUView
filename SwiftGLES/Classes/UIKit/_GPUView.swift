////
////  GPUView.swift
////  Pods
////
////  Created by ryan on 28/04/2017.
////
////
//
//import UIKit
//import GLKit
//
//public enum AGLKViewDrawableDepthFormat : GLint {
//    case formatNone
//    
//    case format16
//    
//    case format24
//}
//
//
//open class AGLKView: UIView {
//
//    private var _colorRenderBuffer: GLuint = 0
//    private var _depthRenderBuffer: GLuint = 0
//    
//    open override class var layerClass: Swift.AnyClass {
//        get {
//            return CAEAGLLayer.classForCoder()
//        }
//    } // default is [CALayer class]. Used when creating the underlying layer for the view.
//
//    
//    public init(frame: CGRect, context: EAGLContext) {
//        super.init(frame: frame)
//        let eaglLayer = self.layer as! CAEAGLLayer
//        
//        eaglLayer.drawableProperties = [kEAGLDrawablePropertyRetainedBacking: false,
//                                        kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8]
//        self.context = context
//    }
//    
//    required public init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        let eaglLayer = self.layer as! CAEAGLLayer
//        eaglLayer.drawableProperties = [kEAGLDrawablePropertyRetainedBacking: false,
//                                        kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8]
//        
//    }
//    
//    private func initialize() {
//        let eaglLayer = self.layer as! CAEAGLLayer
//        
//        eaglLayer.drawableProperties = [kEAGLDrawablePropertyRetainedBacking: false,
//                                        kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8]
//
//    }
//    
//    // TODO Outlet
//    weak open var delegate: AGLKViewDelegate?
//    
//    private var _context: EAGLContext?
//    open var context: EAGLContext {
//        get {
//            return _context ?? nil
//        }
//        set {
//            _context = newValue
//        }
//    }
//    
//    open var drawableWidth: Int {
//        get {
//            var renderBufferWidth: GLint = 0
//            glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_WIDTH), &renderBufferWidth);
//            return Int(renderBufferWidth);
//        }
//    }
//    
//    open var drawableHeight: Int {
//        get {
//            var renderBufferHeight: GLint = 0
//            glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_HEIGHT), &renderBufferHeight);
//            return Int(renderBufferHeight);
//        }
//    }
//    
//    
////    open var drawableColorFormat: AGLKViewDrawableColorFormat
//    
//    open var drawableDepthFormat: AGLKViewDrawableDepthFormat
//    
////    open var drawableStencilFormat: AGLKViewDrawableStencilFormat
//    
////    open var drawableMultisample: GLKViewDrawableMultisample
//    
//    
//    /*
//     Binds the context and drawable. This needs to be called when the currently bound framebuffer
//     has been changed during the draw method.
//     */
//    open func bindDrawable() {
//        
//    }
//    
//    
//    /*
//     deleteDrawable is normally invoked by the GLKViewController when an application is backgrounded, etc.
//     It is the responsibility of the developer to call deleteDrawable when a GLKViewController isn't being used.
//     */
//    open func deleteDrawable() {
//        
//    }
//    
//    
//    /*
//     Returns a UIImage of the resulting draw. Snapshot should never be called from within the draw method.
//     */
////    open var snapshot: UIImage { get }
//    
//    
//    /*
//     Controls whether the view responds to setNeedsDisplay. If true, then the view behaves similarily to a UIView.
//     When the view has been marked for display, the draw method is called during the next drawing cycle. If false,
//     the view's draw method will never be called during the next drawing cycle. It is expected that -display will be
//     called directly in this case. enableSetNeedsDisplay is automatically set to false when used in conjunction with
//     the GLKViewController. This value is true by default.
//     */
//    open var enableSetNeedsDisplay: Bool
//    
//    
//    /*
//     -display should be called when the view has been set to ignore calls to setNeedsDisplay. This method is used by
//     the GLKViewController to invoke the draw method. It can also be used when not using a GLKViewController and custom
//     control of the display loop is needed.
//     */
//    open func display() {
//        
//    }
//    
//    open override func draw(_ rect: CGRect) {
//        if let delegate = self.delegate {
//            delegate.glkView(self, drawIn: rect)
//        }
//    }
//
//    open override func layoutSubviews() {
//        let eaglLayer = self.layer as! CAEAGLLayer
//        
//        // 层的尺寸发生改变，调整视图的缓存的尺寸以匹配层的新尺寸
//        self.context.renderbufferStorage(Int(GL_RENDERBUFFER), from: eaglLayer)
//        
//        glBindBuffer(GLenum(GL_RENDERBUFFER), _colorRenderBuffer)
//        
//        if (0 != _depthRenderBuffer) {
//            glDeleteRenderbuffers(1, &_depthRenderBuffer);
//            _depthRenderBuffer = 0;
//        }
//        
//        let currentDrawableWidth = GLint(self.drawableWidth)
//        let currentDrawableHeight = GLint(self.drawableHeight)
//
//        if (self.drawableDepthFormat != .formatNone && 0 < currentDrawableWidth && 0 < currentDrawableHeight) {
//            glGenRenderbuffers(1, &_depthRenderBuffer);
//            // 告诉OpenGLES在接下来的操作中使用深度缓存
//            glBindRenderbuffer(GLenum(GL_RENDERBUFFER), _depthRenderBuffer);
//            // 配置：指定深度缓存的大小
//            glRenderbufferStorage(GLenum(GL_RENDERBUFFER), GLenum(GL_DEPTH_COMPONENT16), currentDrawableWidth, currentDrawableHeight);
//            // 把深度缓存添加到帧缓存中
//            glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_DEPTH_ATTACHMENT), GLenum(GL_RENDERBUFFER), _depthRenderBuffer);
//        }
//
//    }
//    
////    - (void)layoutSubviews
////    {
////    CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
////    
////    // 层的尺寸发生改变，调整视图的缓存的尺寸以匹配层的新尺寸
////    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:eaglLayer];
////    
////    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
////    
////    if (0 != _depthRenderBuffer) {
////    glDeleteRenderbuffers(1, &_depthRenderBuffer);
////    _depthRenderBuffer = 0;
////    }
////    
////    GLint currentDrawableWidth = (GLint)self.drawableWidth;
////    GLint currentDrawableHeight = (GLint)self.drawableHeight;
////    
////    if (self.drawableDepthFormat != AGLKViewDrawableDepthFormatNone && 0 < currentDrawableWidth && 0 < currentDrawableHeight) {
////    // 生成一个深度缓存标识符
////    glGenRenderbuffers(1, &_depthRenderBuffer);
////    // 告诉OpenGLES在接下来的操作中使用深度缓存
////    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
////    // 配置：指定深度缓存的大小
////    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, currentDrawableWidth, currentDrawableHeight);
////    // 把深度缓存添加到帧缓存中
////    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
////    }
////    
////    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
////    
////    if (status != GL_FRAMEBUFFER_COMPLETE) {
////    NSLog(@"failed to make complete frame buffer object %x",status);
////    }
////    
////    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
////    }
//
//    
//    deinit {
//        if EAGLContext.current() == self.context {
//            EAGLContext.setCurrent(nil)
//        }
//        // TODO??
//        //self.context = nil;
//    }
//}
//
//public protocol AGLKViewDelegate : NSObjectProtocol {
//    
//    
//    /*
//     Required method for implementing GLKViewDelegate. This draw method variant should be used when not subclassing GLKView.
//     This method will not be called if the GLKView object has been subclassed and implements -(void)drawRect:(CGRect)rect.
//     */
//    @available(iOS 5.0, *)
//    func glkView(_ view: AGLKView, drawIn rect: CGRect)
//    
//}
