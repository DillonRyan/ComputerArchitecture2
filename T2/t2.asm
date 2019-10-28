option casemap:none                         ; case sensitive
includelib legacy_stdio_definitions.lib
extrn printf:near
.data
public g ;
g QWORD 4 ;  int g = 4

.code
;
;
;t2.asm
;
;
;


public min_asm
min_asm:
push rbx
mov  rax,rcx	  ; mov to rax
cmp  rdx,rax	  ; (b < v)
jge  bLessV	; branch
mov  rax,rdx     ; (v = b)

bLessV:	  cmp  r8,rax	      ; (c < v)
jge  cLessV	;
mov  rax,r8      	;(v = c)

cLessV:
   pop rbx  ;restore rbx
   ret	; return


public p

p:
push rbx    ;save rbx
sub  rsp, 32                ; allocate stack space
mov  [rsp + 64], r8         ; storing r8
mov  [rsp + 72], r9         ; storing r9
mov  r8, rdx                ; j
mov  rdx, rcx               ; i
mov  rcx, g                 ; g
call min_asm	; call min(g, i, j)
mov  rdx, [rsp + 64]        ; k
mov  r8, [rsp + 72]         ; l
mov  rcx, rax               ; min(min(g, i, j)
call min_asm	; min(min(g, i, j), k, l)
add  rsp, 32                ; take back stack space
pop rbx   ;pop rbx
ret	; return


public gcd

gcd:

cmp  rdx,0	              ; if (b == 0)
jne  NotZero
mov  eax,ecx    	; return a
jmp  bZero        ;else
NotZero:
mov  rax,rcx     ; move first param to rax
mov  rcx,rdx     ; move second param to rdx
cdq	; convert word to double word
idiv rcx	; divide
call gcd                    ; recursion till (b == 0)
bZero:
   ret	; return



fxp1 db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d a+b+c+d+e = %I64d', 0AH, 00H ; ASCII format string
public q
q:
  push rbx	; save rbx
  sub rsp, 48	; allocate stack space + room for params -- alloc stack space a
  mov rbx ,[ rsp + 96]	; get value from the stack as papram 5
  mov rax,rcx	;-setting for adding all - a
  add rax,rdx	;a + b
  add rax, r8	;a + b + c
  add rax,r9	;a + b + c + d
  add rax, rbx	; rax = a + b + c + d + e

  mov [rsp + 48], rax	; push rax onto stack
  mov [rsp + 40], rbx	; push rbx onto stack
  mov [rsp + 32], r9	; push r9 onto stack

  mov rbx,rax	; restore rbx

  mov r9,r8	; storing c
  mov r8, rdx	; storing b
  mov rdx,rcx	; storing a
  lea rcx ,fxp2	; store printf
  call printf	; call printf

  mov rax,rbx	; return sum in rax
  add rsp, 48	; deallocate shadow space
  pop rbx	; restore rbx
  ret 0	; return


fxp2 db 'qns\n', 0AH, 00H ; ASCII format string
public  qns

qns:
                lea  rcx, fxp2
                sub  rsp, 32         ; allocate shadow space
                call printf          ; call printf
                mov  rax,0           ; set to zero
                ;add  rsp, 32         ; deallocate shadow space
                ret                  ; return


end
