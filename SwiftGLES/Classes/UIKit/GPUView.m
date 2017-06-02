//
//  GPUView.m
//  Pods
//
//  Created by ryan on 02/06/2017.
//
//

#import "GPUView.h"

@implementation GPUView

- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)context {
    if (self = [super initWithFrame:frame context:context]) {
        self.drawableDepthFormat = GLKViewDrawableDepthFormat16;
        self.enableSetNeedsDisplay = true;
        self.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;  //颜色缓冲区格式

    }
    return self;
}

- (void)setupVBOs
{
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
//    glBindVertexArrayOES(0);
    
//    if (!self.useCylinders)
//    {
//        glGenVertexArraysOES(1, &_vertexArray);
//        glBindVertexArrayOES(_vertexArray);
//        
//        //    GLuint texCoordBuffer;
//        glGenBuffers(1, &_vertexBuffer);
//        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
//        glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
//        
//        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
//        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
//        glEnableVertexAttribArray(GLKVertexAttribNormal);
//        
//    }
//    else
//    {
//        glGenVertexArraysOES(1, &_vertexCylinder);
//        glBindVertexArrayOES(_vertexCylinder);
//        
//        glGenBuffers(1, &_vertexBuffer6);
//        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer6);
//        glBufferData(GL_ARRAY_BUFFER, 4 * [self numberCylinderFacets] * 6 * 3 * sizeof(float), cylinderBuffer, GL_STATIC_DRAW);
//        
//        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
//        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
//        glEnableVertexAttribArray(GLKVertexAttribNormal);
//    }
//    
//    {
//        glGenVertexArraysOES(1, &_vertexArrayHLine);
//        glBindVertexArrayOES(_vertexArrayHLine);
//        
//        glGenBuffers(1, &_vertexBuffer2);
//        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer2);
//        glBufferData(GL_ARRAY_BUFFER, sizeof(gHLineVertexData), gHLineVertexData, GL_STATIC_DRAW);
//        
//        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
//        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
//        glEnableVertexAttribArray(GLKVertexAttribNormal);
//        
//    }
//    {
//        glGenVertexArraysOES(1, &_vertexArrayVLine);
//        glBindVertexArrayOES(_vertexArrayVLine);
//        
//        glGenBuffers(1, &_vertexBuffer3);
//        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer3);
//        glBufferData(GL_ARRAY_BUFFER, sizeof(gVLineVertexData), gVLineVertexData, GL_STATIC_DRAW);
//        
//        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
//        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
//        glEnableVertexAttribArray(GLKVertexAttribNormal);
//    }
//    
//    {
//        glGenVertexArraysOES(1, &_vertexArrayBasePlane);
//        glBindVertexArrayOES(_vertexArrayBasePlane);
//        
//        glGenBuffers(1, &_vertexBuffer4);
//        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer4);
//        glBufferData(GL_ARRAY_BUFFER, sizeof(gBasePlaneData), gBasePlaneData, GL_STATIC_DRAW);
//        
//        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
//        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
//        glEnableVertexAttribArray(GLKVertexAttribNormal);
//    }
//    
//    {
//        glGenVertexArraysOES(1, &_vertexLeftLegendPlane);
//        glBindVertexArrayOES(_vertexLeftLegendPlane);
//        
//        glGenBuffers(1, &_vertexBuffer5);
//        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer5);
//        glBufferData(GL_ARRAY_BUFFER, sizeof(gLeftLegendPlaneData), gLeftLegendPlaneData, GL_STATIC_DRAW);
//        
//        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(0));
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
//        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(12));
//        glEnableVertexAttribArray(GLKVertexAttribNormal);
//        
//        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(24));
//        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    }
//    
//    { // gTopTextData
//        glGenVertexArraysOES(1, &_vertexTopText);
//        glBindVertexArrayOES(_vertexTopText);
//        
//        glGenBuffers(1, &_vertexBuffer7);
//        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer7);
//        glBufferData(GL_ARRAY_BUFFER, sizeof(gTopTextData), gTopTextData, GL_STATIC_DRAW);
//        
//        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(0));
//        glEnableVertexAttribArray(GLKVertexAttribPosition);
//        
//        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(12));
//        glEnableVertexAttribArray(GLKVertexAttribNormal);
//        
//        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(24));
//        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    }
//    
//    
//    
//    glBindBuffer(GL_ARRAY_BUFFER, 0);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
//    
    
}


- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [self setupVBOs];
    
    glEnable(GL_DEPTH_TEST);
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    
//    self.effect = [[GLKBaseEffect alloc] init];
//    self.effect.light0.enabled = GL_TRUE;
//    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
//    self.effect.light0.position = GLKVector4Make(+2.0, 2.0, +2.0, 0.0);
//    
//    self.effect.material.shininess = 100.0;
//    self.effect.material.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
}



@end
