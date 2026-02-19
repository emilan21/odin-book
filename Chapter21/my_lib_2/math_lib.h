#ifndef MATH_LIB_H
#define MATH_LIB_H

// 2D Vector
typedef struct Vec2 {
    float x;
    float y;
} Vec2;

// 3D Vector
typedef struct Vec3 {
    float x;
    float y;
    float z;
} Vec3;

// 3x3 Matrix
typedef struct Mat3 {
    float data[3][3];
} Mat3;

// Progress callback for long operations
typedef void (*ProgressCallback)(int step, int total, const char* operation);

// Vector operations
Vec2 vec2_add(Vec2 a, Vec2 b);
Vec2 vec2_sub(Vec2 a, Vec2 b);
Vec2 vec2_scale(Vec2 v, float scalar);
float vec2_dot(Vec2 a, Vec2 b);
float vec2_length(Vec2 v);
Vec2 vec2_normalize(Vec2 v);

Vec3 vec3_add(Vec3 a, Vec3 b);
Vec3 vec3_sub(Vec3 a, Vec3 b);
Vec3 vec3_scale(Vec3 v, float scalar);
Vec3 vec3_cross(Vec3 a, Vec3 b);
float vec3_dot(Vec3 a, Vec3 b);
float vec3_length(Vec3 v);
Vec3 vec3_normalize(Vec3 v);

// Matrix operations
Mat3 mat3_identity(void);
Mat3 mat3_multiply(Mat3 a, Mat3 b);
Vec3 mat3_multiply_vec3(Mat3 m, Vec3 v);
Mat3 mat3_transpose(Mat3 m);
float mat3_determinant(Mat3 m);
Mat3 mat3_inverse(Mat3 m);

// Statistics
float mean(float* values, int count);
float variance(float* values, int count);
float standard_deviation(float* values, int count);
float min_value(float* values, int count);
float max_value(float* values, int count);

// Trigonometry
float degrees_to_radians(float degrees);
float radians_to_degrees(float radians);
float lerp(float a, float b, float t);
float clamp(float value, float min, float max);

// Set callback for progress reporting
void set_progress_callback(ProgressCallback callback);

#endif
