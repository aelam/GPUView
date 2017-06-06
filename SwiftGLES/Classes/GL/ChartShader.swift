//
//  ChartShader.swift
//  Pods
//
//  Created by ryan on 06/06/2017.
//
//

import OpenGLES

open class ChartShader: NSObject {
    open var shaderId: GLuint!
    // Program Handle
    open var program: GLuint!
    // Attribute Handles
    open var theta: GLint!
    // Uniform Handles
    open var projectionMatrix: GLint!
    open var modelViewMatrix: GLint!
    open var k: GLint!
    
    open func loadShader() {
        theta = glGetAttribLocation(program, "theta")
        projectionMatrix = glGetUniformLocation(program, "projectionMatrix")
        modelViewMatrix = glGetUniformLocation(program, "modelViewMatrix")
        k = glGetUniformLocation(program, "k")
    }
}
