.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive
  public g


.code
;
; t1.asm
;
;
;
;

 g DWORD 4 ;int g = 4 - global

public min_asm
min_asm:
push ebp ;push Frame
mov ebp, esp ;update
push ebx	;	save non volitile regs
mov eax,[ebp + 8] ;v = a
cmp [ebp + 12],eax ;if(b < v)
jge bLessV ;branch if B is less than V
mov eax,[ebp + 12] ;(v = b)
bLessV:
cmp [ebp + 16],eax ;if(c < v)
jge cLessV ;
mov eax,[ebp + 16] ;(v = c)
cLessV:
pop ebx ;resotre saved register
mov esp, ebp ;restore esp
pop ebp ;restore previous ebp
ret ;return


public p
p:
push ebp ;push frame
mov ebp,esp ;update
push g ;
push [ebp + 8] ; i
push [ebp + 12] ;j
call min_asm ;call min_asm(g,i,j)
push [ebp + 16] ;k
push [ebp + 20] ;l
push eax ;min_asm(g,i,j)
call min_asm	;min_asm(min_asm(g,i,j),k,l)
pop ebx ;restore registers
mov esp, ebp ;restore esp
pop ebp ;restore frame pointer
ret ;

public gcd
gcd:
push ebp ;push frame
mov ebp, esp ;update
push ebx	;save non volatile regs
mov eax,[ebp +12] ;setting b
cmp eax, 0 ;(b ==0)
jne  notZero  ;
mov  eax,[ebp+8] ; returning b
jmp  isZero ;

notZero:
mov  eax,[ebp+8] ; gcd(b, a % b);
cdq ; convert word to double word
mov  ebx,[ebp+12] ; set  b
idiv ebx ; divide
push edx    ;
push ebx    ;
call gcd                    ; recursion till (b == 0)
pop ebx ; restore registers



isZero:
mov  esp, ebp ; restore esp
pop  ebp ; restore frame pointer
ret ;

end
