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

    private var triangleVertexBuffer: GLuint = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let context = EAGLContext.init(api: .openGLES3)
        let aGLKView = GLKView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), context: context!)
        aGLKView.delegate = self
        aGLKView.drawableDepthFormat = .format16
        aGLKView.enableSetNeedsDisplay = true
        aGLKView.drawableColorFormat = .RGBA8888;  //颜色缓冲区格式

        self.view.addSubview(aGLKView)
        
        
        EAGLContext.setCurrent(context)
        prepareTriangles()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0, 0.2, 0.5, 1.0);
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT));
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue));

        glDrawArrays(GLenum(GL_TRIANGLES), 0, 6);
        glDisableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue));

    }
    
    
    private func prepareTriangles() {
        let postion: [Float] = [
            0.5, -0.5, 0.0,       1.0, 0.0, // 右下
            0.5,  0.5, 0.0,       1.0, 1.0, // 右上
            -0.5,  0.5, 0.0,      0.0, 1.0, // 左上
            
            0.5, -0.5, 0.0,       1.0, 0.0, // 右下
            -0.5, -0.5, 0.0,      0.0, 0.0, // 左下
            -0.5,  0.5, 0.0,      0.0, 1.0  // 左上
        ];

        let floatSize = MemoryLayout<Float>.size
        
//        var triangleVertexBuffer: GLuint = 0
        // 生成一个缓存标识符,0值表示没有缓存
        glGenBuffers(1, &triangleVertexBuffer);
        // glBindBuffer第一个参数说明绑定哪一种类型的缓存。GLES2.0版本只支持两种类型 GL_ARRAY_BUFFER\GL_ELEMENT_ARRAY_BUFFER。
        // GL_ARRAY_BUFFER类型用于指定一个顶点属性数组。
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), triangleVertexBuffer);
        glBufferData(GLenum(GL_ARRAY_BUFFER), floatSize, postion, GLenum(GL_STATIC_DRAW));

//        _ indx: GLuint, 
//        _ size: GLint,
//        _ type: GLenum, 
//        _ normalized: GLboolean,
//        _ stride: GLsizei, 
//        _ ptr: UnsafeRawPointer!
        glVertexAttribPointer(GLuint(GLKVertexAttrib.position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(floatSize * 5), nil)

    }

}

