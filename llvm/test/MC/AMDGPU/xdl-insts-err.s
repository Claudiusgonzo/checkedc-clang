// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx906 -show-encoding %s 2>&1 | FileCheck --check-prefixes=GCN-ERR,GFX906-ERR %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx908 -show-encoding %s 2>&1 | FileCheck --check-prefixes=GCN-ERR,GFX908-ERR %s

// GFX906-ERR: error: instruction not supported on this GPU
v_dot2c_f32_f16 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot2c_f32_f16_e64 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot2c_f32_f16_sdwa v0, v1, v2

// GFX906-ERR: error: instruction not supported on this GPU
v_dot2c_i32_i16 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot2c_i32_i16_e64 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot2c_i32_i16_sdwa v0, v1, v2

// GFX906-ERR: error: instruction not supported on this GPU
v_dot4c_i32_i8 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot4c_i32_i8_e64 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot4c_i32_i8_sdwa v0, v1, v2

// GFX906-ERR: error: instruction not supported on this GPU
v_dot8c_i32_i4 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot8c_i32_i4_e64 v0, v1, v2

// GCN-ERR: error: invalid instruction
v_dot8c_i32_i4_sdwa v0, v1, v2

// GFX906-ERR: error: instruction not supported on this GPU
v_pk_fmac_f16 v0, v1, v2
