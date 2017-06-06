attribute float theta;

// Uniforms
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform float pointSize;
uniform float k;

void main(void)
{
    gl_Position = projectionMatrix * vec4(x, y, 0.0, 1.0);
    gl_PointSize = pointSize;
}
