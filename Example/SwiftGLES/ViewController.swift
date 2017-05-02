//
//  ViewController.swift
//  SwiftGLES
//
//  Created by aelam on 04/28/2017.
//  Copyright (c) 2017 aelam. All rights reserved.
//

import UIKit
import GLKit
import SwiftGLES

class ViewController: UIViewController, GLKViewDelegate {

    @IBOutlet private var aGLKView: GLKView!
    private let context = EAGLContext(api: .openGLES3)
    @IBOutlet private var glkView: GLKView!
    
    private var mEffect = GLKBaseEffect()
    private var vertexBuffer: GLuint = 0
    
    private var t1: GLKTextureInfo?
    private var t2: GLKTextureInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        “GLint iUnits;

//        glGetIntegerv(GL_MAX_TEXTURE_UNITS, &iUnits);”
        let context = EAGLContext.init(api: .openGLES3)
        let aGLKView = GLKView(frame: CGRect(x: 0, y: 0, width: 375, height: 400), context: context!)
        aGLKView.delegate = self
        aGLKView.drawableDepthFormat = .format16
        aGLKView.enableSetNeedsDisplay = true
        aGLKView.drawableColorFormat = .RGBA8888;  //颜色缓冲区格式

        self.view.addSubview(aGLKView)
        
        EAGLContext.setCurrent(context)
        prepareTriangles()
        prepareTexture()

        var maxUnit: GLint = 0
        glGetIntegerv(GLenum(GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS), &maxUnit)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.2, 0.2, 0.5, 1.0);
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT));
        

        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue));

        // t1
        mEffect.texture2d0.enabled = GLboolean(GL_TRUE);
        mEffect.useConstantColor = GLboolean(GL_FALSE)
//        mEffect.constantColor = GLKVector4(v: (1.0, 0.0 ,0.0, 1.0))
        self.mEffect.texture2d0.name = (t1?.name)!
        mEffect.prepareToDraw()
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 6);

        // t2
        mEffect.useConstantColor = GLboolean(GL_FALSE)
//        mEffect.constantColor = GLKVector4(v: (1.0, 0.0 ,1.0, 1.0))
        self.mEffect.texture2d0.name = (t2?.name)!
        mEffect.prepareToDraw()
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 6);

        glDisableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue));

        
    }
    
    
    private func prepareTriangles() {
        let position: [Float] = [
            0.5, -0.5, 0.0,       1.0, 0.0, // 右下
            0.5,  0.5, 0.0,       1.0, 1.0, // 右上
            -0.5,  0.5, 0.0,      0.0, 1.0, // 左上
            
            0.5, -0.5, 0.0,       1.0, 0.0, // 右下
            -0.5, -0.5, 0.0,      0.0, 0.0, // 左下
            -0.5,  0.5, 0.0,      0.0, 1.0  // 左上
        ];

        let floatSize = MemoryLayout<Float>.size
        
//        var vertexBuffer: GLuint = 0
        // 生成一个缓存标识符,0值表示没有缓存
        glGenBuffers(1, &vertexBuffer);
        // glBindBuffer第一个参数说明绑定哪一种类型的缓存。GLES2.0版本只支持两种类型 GL_ARRAY_BUFFER\GL_ELEMENT_ARRAY_BUFFER。
        // GL_ARRAY_BUFFER类型用于指定一个顶点属性数组。
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer);
        glBufferData(GLenum(GL_ARRAY_BUFFER), floatSize * position.count, position, GLenum(GL_STATIC_DRAW));

        // 点
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue))
//        _ indx: GLuint,
//        _ size: GLint,
//        _ type: GLenum, 
//        _ normalized: GLboolean,
//        _ stride: GLsizei, 
//        _ ptr: UnsafeRawPointer!
        glVertexAttribPointer(GLuint(GLKVertexAttrib.position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(floatSize * 5), nil)

        // 文理
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.texCoord0.rawValue));
        let ptr = UnsafeRawPointer(bitPattern: floatSize * 3)
        glVertexAttribPointer(GLuint(GLKVertexAttrib.texCoord0.rawValue), 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(floatSize * 5), ptr);

    }
    
    private func prepareTexture() {
        
        let options = [GLKTextureLoaderOriginBottomLeft: 1 as NSNumber]
        let path = Bundle.main.path(forResource: "for_test.jpg", ofType: nil)!
        let tex: GLKTextureInfo?
        do {
            try tex = GLKTextureLoader.texture(withContentsOfFile: path, options: options)
        } catch {
            tex = nil
        }
        
        t1 = tex
        
        let path2 = Bundle.main.path(forResource: "beetle.png", ofType: nil)!
        let tex2: GLKTextureInfo?
        do {
            try tex2 = GLKTextureLoader.texture(withContentsOfFile: path2, options: options)
        } catch {
            tex2 = nil
        }
        
        t2 = tex2


        glEnable(GLenum(GL_BLEND));
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA));
        

    }
    
    deinit {
        glDeleteBuffers(1, &vertexBuffer)
    }

}

