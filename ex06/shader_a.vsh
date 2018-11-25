#version 150

in vec4 aPosition;
in vec3 aNormal;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec3 uLightPosition;
uniform vec3 uLightColor;

uniform mat3 uAmbientMaterial;
uniform mat3 uDiffuseMaterial;
uniform mat3 uSpecularMaterial;
uniform float uSpecularityExponent;
 
out vec3 vColor;

void main() {
    // Transform to eye-space
    vec4 newPosition = uModelViewMatrix * aPosition;

    // Transform normals using the correct matrix.
    // It's important to normalize in the end
    vec3 newNormal = normalize( vec3( inverse(transpose(uModelViewMatrix)) * vec4(aNormal, 0.0)) );

    // write the final vertex position into this variable
    gl_Position = uProjectionMatrix * newPosition;
    // Define the color of this vertex
    const vec3 zeros = vec3 (0.0, 0.0, 0.0);
    C_d = max( zeros, uDiffuseMaterial * uLightColor * transpose(newNormal) * normalize(uLightPosition- vec3(newPosition)) );
    h = normalize( normalize(uLightPosition - vec3(newPosition)) + normalize( -vec3(newPosition)));
    C_sp = max(zeros, uSpecularMaterial * uLightColor * pow( (transpose(newNormal) * h ), uSpecularityExponent ));
    vColor = normalize ( uAmbientMaterial * uLightColor + C_d + C_sp);
}


