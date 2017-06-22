//
//  Program.swift
//  Pods
//
//  Created by ryan on 06/06/2017.
//
//

#if os(iOS)
    import OpenGLES
#else
    import OpenGL
#endif

open class GLProgram: NSObject {
    
    open private(set) var programId: GLuint!
    open private(set) var vertexShader: Shader!
    open private(set) var fragShader: Shader!
    open private(set) var isInitialized: Bool = false
    
    public func link() -> Bool {

        glLinkProgram(programId)
//        glGetProgramiv(programId, GLenum(GL_LINK_STATUS), &status)
//        if status == GL_FALSE {
//            return false
//        }

        if vertexShader.id != 0 {
            glDeleteShader(vertexShader.id)
            vertexShader.id = 0
        }
        
        if fragShader.id != 0 {
            glDeleteShader(vertexShader.id)
            fragShader.id = 0
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
        if vertexShader.id != 0 {
            glDeleteShader(vertexShader.id)
            vertexShader.id = 0
        }
        
        if fragShader.id != 0 {
            glDeleteShader(vertexShader.id)
            fragShader.id = 0
        }
        
        if programId != 0 {
            glDeleteProgram(programId)
        }
    }
}
