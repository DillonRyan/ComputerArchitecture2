#pragma once

//
// t1.h
//
//

//
// NB: "extern C" to avoid procedure name mangling by compiler
//
extern "C" int g;
extern "C" int _cdecl min_asm(int, int, int);   // _cdecl calling convention
extern "C" int _cdecl p(int, int, int, int);   // _cdecl calling convention
extern "C" int _cdecl gcd(int, int);   // _cdecl calling convention

// eof
