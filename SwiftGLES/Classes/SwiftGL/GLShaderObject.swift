//
//  Shader.swift
//  Pods
//
//  Created by ryan on 26/06/2017.
//
//

#if os(OSX)
    import Cocoa
    import OpenGL
#else
    import Foundation
    import OpenGLES

#endif

class GLShaderObject: NSObject {
    public typealias GLShaderId = GLuint
    
    fileprivate class func ptr <T> (_ ptr: UnsafePointer<T>) -> UnsafePointer<T> { return ptr }

    public class func compile(_ type: GLenum, _ source: String) -> GLShaderId {
        if let csource: [GLchar] = source.cString(using: String.Encoding.ascii) {
            let cptr = ptr(csource)
            
            let shader = glCreateShader(type)
            glShaderSource(shader, 1, [cptr], nil)
            glCompileShader(shader)
            
            var logLength: GLint = 0
            glGetShaderiv(shader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            if logLength > 0 {
                let log = malloc(Int(logLength)).assumingMemoryBound(to: CChar.self)
                glGetShaderInfoLog(shader, logLength, &logLength, log)
                print("Shader compile log: \(String(describing: log))")
                free(log)
            }
            
            var status: GLint = 0
            glGetShaderiv(shader, GLenum(GL_COMPILE_STATUS), &status)
            if status == GLint(GL_FALSE) {
                print("Failed to compile shader: \(csource)")
                return 0
            }
            
            return shader
        }
        
        return 0
    }

}
