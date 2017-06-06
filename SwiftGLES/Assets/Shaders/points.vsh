attribute vec4 position;
attribute vec4 v_color;

varying vec4 colorVarying;

void main()
{
    colorVarying = v_color;
    gl_Position = position;
    gl_PointSize = 3;
}

