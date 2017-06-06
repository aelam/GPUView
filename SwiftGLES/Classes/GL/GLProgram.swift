//
//  Program.swift
//  Pods
//
//  Created by ryan on 06/06/2017.
//
//

#if (arch(i386) || arch(x86_64)) && os(iOS)  /*IPHONE_SIMULATOR IPHONE_DEVICE */
import OpenGLES
#else
import OpenGL
#endif

open class GLProgram: NSObject {
    
    open private(set) var programId: GLuint!
    open private(set) var vertexShader: Shader!
    open private(set) var fragShader: Shader!
    open private(set) var isInitialized: Bool = false

    
    public init(_ vertexShader: Shader, _ fragShader: Shader) {
        
    }
    
    
    public func link() -> Bool {
        var status: GLint = 0

        glLinkProgram(programId)
        glGetProgramiv(programId, GLenum(GL_LINK_STATUS), &status)
        if status == GL_FALSE {
            return false
        }

        if vertexShader.shaderId != 0 {
            glDeleteShader(vertexShader.shaderId)
            vertexShader.shaderId = 0
        }
        
        if fragShader.shaderId != 0 {
            glDeleteShader(vertexShader.shaderId)
            fragShader.shaderId = 0
        }
        
        isInitialized = true
        
        return true
    }
    
    public func use() {
        glUseProgram(programId)
    }
    
    public func validate() {
    
    }
    
    deinit {
        if vertexShader.shaderId != 0 {
            glDeleteShader(vertexShader.shaderId)
            vertexShader.shaderId = 0
        }
        
        if fragShader.shaderId != 0 {
            glDeleteShader(vertexShader.shaderId)
            fragShader.shaderId = 0
        }
        
        if programId != 0 {
            glDeleteProgram(programId)
        }
    }
}
