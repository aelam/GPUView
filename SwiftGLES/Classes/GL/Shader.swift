//
//  Shader.swift
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

public enum ShaderType {
    case vertex
    case fragment
}

open class Shader: NSObject {
    open var shaderId: GLuint = 0
    open private(set) var shaderType: ShaderType
    
    public init(_ shaderType: ShaderType, source: String) {
        self.shaderType = shaderType
        
        let glShaderType = (shaderType == .vertex) ? GL_VERTEX_SHADER : GL_FRAGMENT_SHADER
        let glShader = glCreateShader(GLenum(glShaderType))
        
//        glShaderSource(glShader, 1, &, nil);

    }
    
    public func delete() {
    
    }
    
}
