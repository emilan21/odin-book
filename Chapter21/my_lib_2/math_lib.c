#include <math.h>
#include <stdio.h>
#include "math_lib.h"

static ProgressCallback progress_callback = NULL;

void set_progress_callback(ProgressCallback callback) {
    progress_callback = callback;
}

static void report_progress(int step, int total, const char* operation) {
    if (progress_callback) {
        progress_callback(step, total, operation);
    }
}

// ===== 2D Vector Operations =====
Vec2 vec2_add(Vec2 a, Vec2 b) {
    return (Vec2){a.x + b.x, a.y + b.y};
}

Vec2 vec2_sub(Vec2 a, Vec2 b) {
    return (Vec2){a.x - b.x, a.y - b.y};
}

Vec2 vec2_scale(Vec2 v, float scalar) {
    return (Vec2){v.x * scalar, v.y * scalar};
}

float vec2_dot(Vec2 a, Vec2 b) {
    return a.x * b.x + a.y * b.y;
}

float vec2_length(Vec2 v) {
    return sqrtf(v.x * v.x + v.y * v.y);
}

Vec2 vec2_normalize(Vec2 v) {
    float len = vec2_length(v);
    if (len == 0.0f) return (Vec2){0.0f, 0.0f};
    return vec2_scale(v, 1.0f / len);
}

// ===== 3D Vector Operations =====
Vec3 vec3_add(Vec3 a, Vec3 b) {
    return (Vec3){a.x + b.x, a.y + b.y, a.z + b.z};
}

Vec3 vec3_sub(Vec3 a, Vec3 b) {
    return (Vec3){a.x - b.x, a.y - b.y, a.z - b.z};
}

Vec3 vec3_scale(Vec3 v, float scalar) {
    return (Vec3){v.x * scalar, v.y * scalar, v.z * scalar};
}

Vec3 vec3_cross(Vec3 a, Vec3 b) {
    return (Vec3){
        a.y * b.z - a.z * b.y,
        a.z * b.x - a.x * b.z,
        a.x * b.y - a.y * b.x
    };
}

float vec3_dot(Vec3 a, Vec3 b) {
    return a.x * b.x + a.y * b.y + a.z * b.z;
}

float vec3_length(Vec3 v) {
    return sqrtf(v.x * v.x + v.y * v.y + v.z * v.z);
}

Vec3 vec3_normalize(Vec3 v) {
    float len = vec3_length(v);
    if (len == 0.0f) return (Vec3){0.0f, 0.0f, 0.0f};
    return vec3_scale(v, 1.0f / len);
}

// ===== Matrix Operations =====
Mat3 mat3_identity(void) {
    Mat3 m = {{{0}}};
    m.data[0][0] = m.data[1][1] = m.data[2][2] = 1.0f;
    return m;
}

Mat3 mat3_multiply(Mat3 a, Mat3 b) {
    Mat3 result = {{{0}}};
    report_progress(1, 3, "Matrix multiplication");
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            for (int k = 0; k < 3; k++) {
                result.data[i][j] += a.data[i][k] * b.data[k][j];
            }
        }
    }
    
    report_progress(3, 3, "Matrix multiplication");
    return result;
}

Vec3 mat3_multiply_vec3(Mat3 m, Vec3 v) {
    return (Vec3){
        m.data[0][0] * v.x + m.data[0][1] * v.y + m.data[0][2] * v.z,
        m.data[1][0] * v.x + m.data[1][1] * v.y + m.data[1][2] * v.z,
        m.data[2][0] * v.x + m.data[2][1] * v.y + m.data[2][2] * v.z
    };
}

Mat3 mat3_transpose(Mat3 m) {
    Mat3 result;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            result.data[i][j] = m.data[j][i];
        }
    }
    return result;
}

float mat3_determinant(Mat3 m) {
    return m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
         - m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
         + m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0]);
}

Mat3 mat3_inverse(Mat3 m) {
    float det = mat3_determinant(m);
    if (fabsf(det) < 1e-6f) {
        return mat3_identity();
    }
    
    report_progress(1, 2, "Matrix inversion");
    
    Mat3 result;
    float inv_det = 1.0f / det;
    
    result.data[0][0] = (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1]) * inv_det;
    result.data[0][1] = (m.data[0][2] * m.data[2][1] - m.data[0][1] * m.data[2][2]) * inv_det;
    result.data[0][2] = (m.data[0][1] * m.data[1][2] - m.data[0][2] * m.data[1][1]) * inv_det;
    result.data[1][0] = (m.data[1][2] * m.data[2][0] - m.data[1][0] * m.data[2][2]) * inv_det;
    result.data[1][1] = (m.data[0][0] * m.data[2][2] - m.data[0][2] * m.data[2][0]) * inv_det;
    result.data[1][2] = (m.data[0][2] * m.data[1][0] - m.data[0][0] * m.data[1][2]) * inv_det;
    result.data[2][0] = (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0]) * inv_det;
    result.data[2][1] = (m.data[0][1] * m.data[2][0] - m.data[0][0] * m.data[2][1]) * inv_det;
    result.data[2][2] = (m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]) * inv_det;
    
    report_progress(2, 2, "Matrix inversion");
    return result;
}

// ===== Statistics =====
float mean(float* values, int count) {
    if (count <= 0) return 0.0f;
    float sum = 0.0f;
    for (int i = 0; i < count; i++) {
        sum += values[i];
    }
    return sum / count;
}

float variance(float* values, int count) {
    if (count <= 1) return 0.0f;
    float m = mean(values, count);
    float sum = 0.0f;
    for (int i = 0; i < count; i++) {
        float diff = values[i] - m;
        sum += diff * diff;
    }
    return sum / count;
}

float standard_deviation(float* values, int count) {
    return sqrtf(variance(values, count));
}

float min_value(float* values, int count) {
    if (count <= 0) return 0.0f;
    float min = values[0];
    for (int i = 1; i < count; i++) {
        if (values[i] < min) min = values[i];
    }
    return min;
}

float max_value(float* values, int count) {
    if (count <= 0) return 0.0f;
    float max = values[0];
    for (int i = 1; i < count; i++) {
        if (values[i] > max) max = values[i];
    }
    return max;
}

// ===== Trigonometry =====
float degrees_to_radians(float degrees) {
    return degrees * (3.14159265359f / 180.0f);
}

float radians_to_degrees(float radians) {
    return radians * (180.0f / 3.14159265359f);
}

float lerp(float a, float b, float t) {
    return a + (b - a) * t;
}

float clamp(float value, float min, float max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}
