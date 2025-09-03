#!/bin/bash

# Test GUI applications in the container
echo "Testing GUI applications..."

# Test OpenGL
echo "Testing OpenGL..."
glxinfo | head -20 || echo "glxinfo failed"

# Test xeyes
echo "Testing xeyes..."
timeout 5s xeyes || echo "xeyes failed"

# Test xclock
echo "Testing xclock..."
timeout 5s xclock || echo "xclock failed"

# Test xterm
echo "Testing xterm..."
timeout 5s xterm -e "echo 'X11 is working!' && sleep 2" || echo "xterm failed"

# Test DISPLAY variable
echo "Current DISPLAY: $DISPLAY"

# Test XAUTHORITY
echo "Current XAUTHORITY: $XAUTHORITY"

# Test OpenGL environment variables
echo "LIBGL_ALWAYS_SOFTWARE: $LIBGL_ALWAYS_SOFTWARE"
echo "MESA_GL_VERSION_OVERRIDE: $MESA_GL_VERSION_OVERRIDE"

echo "GUI test completed." 