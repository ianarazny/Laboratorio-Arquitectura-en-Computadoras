.data  ; Segmento de datos

;Declaración de la pila, tope y otras constantes.
pila dw dup(31) 0x0000
tope dw -2
ENTRADA EQU 0

PUERTO_SALIDA_DEFECTO EQU 0x0002
PUERTO_LOG_DEFECTO EQU 0x0001

puertoSalida dw PUERTO_SALIDA_DEFECTO 
puertoSalidaBit dw PUERTO_LOG_DEFECTO

.code  ; Segmento de código

esperarCodigo:
	IN AX, ENTRADA	

;Mostrar en la bitácora:
	PUSH DX ;Guardo la información previa que haya en DX
	PUSH AX ;Guardo la información previa que haya en AX

	MOV DX, [puertoSalidaBit] ;Muevo a DX el puerto salida de la bitácora
	MOV AX, 0 
	OUT DX, AX ;Muestro en el puerto salida de la bitácora el 0 almacenado en la línea anterior.

	POP AX ;Devuelvo el valor previo de AX (i.e.: la entrada)
	OUT DX, AX ;Muestro en el puerto de bitácora (aún en DX) el código de entrada
	POP DX ;Devuelvo el valor anterior de DX.

;-----------------------------------CASOS--------------------------------
;--CASO 1
CMP AX, 0x0001; Si ingreso es porque el código ingresado fue 1, ingreso al Case 1
JZ case1
;FIN CASO 1

;--caso 2
CMP AX, 0x0002; Case 2
JZ case2
;--FIN CASO 2--

;--CASO 3
CMP AX, 0X0003; Case 3
JZ case3
;--FIN CASO 3

;--CASO 4--
CMP AX, 0X0004
JZ case4
;--FIN CASO4

;--CASO 5--
CMP AX, 0X0005
JZ case5
;--FIN CASO 5

;--CASO 6
CMP AX, 0X0006
JZ case6
;--FIN CASO 6

;--CASO 7
CMP AX,0X0007
JZ case7
;--FIN CASO 7

;--CASO 8--
CMP AX, 0X0008
JZ case8
;--FIN CASO 8

;--CASO 9
CMP AX, 0X0009
JZ case9
;--FIN CASO 9

;--CASO 10
CMP AX, 0X000A
JZ case10
;--FIN CASO 10

;--CASO 11
CMP AX, 0X000B
JZ case11
;--FIN CASO 11

;--CASO 12
CMP AX, 0X000C
JZ case12
;--FIN CASO 12

;--CASO 13
CMP AX, 0X000D
JZ case13
;--FIN CASO 13

;--CASO 14
CMP AX, 0X000E
JZ case14
;--FIN CASO 14

;--CASO 15
CMP AX, 0X000F
JZ case15 
;--FIN CASO 15

;--CASO 16
CMP AX, 0X0010
JZ case16
;--FIN CASO 16

;--CASO 17
CMP AX, 0X0011
JZ case17
;--FIN CASO 17

;--CASO 18
CMP AX, 0X0012
JZ case18
;--FIN CASO 18

;--CASO 19
CMP AX, 0X0013
JZ case19
;--FIN CASO 19

;--CASO 254
CMP AX, 0X00FE
JZ case254
;--FIN CASO 254

;CASO 255, HALT
CMP AX, 0X00FF
JZ case255
;--FIN CASO 255

;En otro caso, el código no fue reconocido, código de error 2.
	PUSH DX
	MOV DX, [puertoSalidaBit] ;debería ser puertoSalidaBit
	PUSH AX
	MOV AX, 2
	OUT DX, AX
	POP AX
	POP DX
	JMP esperarCodigo
;-----------------Especificación de los casos--------------------------------
case1 : 
	CMP word ptr [tope], 60;Hasta que sea 60
	JL apilar ;Si no se desborda, es decir, tenemos tope<=30, apilamos.
;else
	JMP desbordada
;FIN CASE 1.

case2 :
	IN AX, ENTRADA

	;Muestro el puerto en la salida
	PUSH DX
	MOV DX, [puertoSalidaBit]
	OUT DX, AX
	POP DX
	;Seteo el nuevo puerto de salida.
	MOV [puertoSalida], AX ;
	JMP exito

case3 :
	IN AX, ENTRADA
	
	;Muestro el puerto en la salida
	PUSH DX
	MOV DX, [puertoSalidaBit]
	OUT DX, AX
	POP DX
	;Seteo el nuevo puerto
	MOV [puertoSalidaBit], AX
	JMP exito
	
case4 :
;if(tope<0)
	CMP word ptr [tope], 0
	JL insufElems
;else
	PUSH DX
	MOV DX, [puertoSalida] ;
	PUSH AX
	;Previamente tengo en SI el tope cuando apilé

	MOV AX, [pila+SI] ;[pila+SI] -> elem del tope.
	OUT DX, AX
	POP AX
	POP DX
	JMP exito
;FIN CASE 4
	

case5 : 
	PUSH BX
	MOV BX, [tope]
	CMP word ptr [tope], 0
	JGE cicloDump
	;En caso de que no tenga elementos, retorno el código 16 igual (salto a la etiqueta de exito)
	POP BX
	JMP exito
;FIN CASE 5

case6 :
	CMP word ptr [tope], 0
	JL insufElems
	
	CMP word ptr [tope], 60
	JGE desbordadaYNoEsperoSalida
	
	MOV AX, [pila+SI] ; Pongo el tope en AX
	ADD word ptr [tope], 0x0002 ;tope--
	MOV SI, [tope] ;Actualizo el SI con el tope
	MOV [pila+SI], AX ; Pongo el valor del tope anterior en la siguiente posición
	JMP exito
;FIN CASE 6
	
case7 : 
	CMP word ptr [tope], 0
	JE desapiloPorFalta
	JL insufElems
	
	PUSH AX 
	PUSH BX
	;En SI poseo el tope actual
	MOV AX, [pila + SI]
	SUB SI, 2 ;En SI siempre se encuentra el tope actual.
	MOV BX, [pila + SI] ;Guardo en BX el elemento en la posición tope-1
	MOV [pila + SI], AX 
	ADD SI, 2
	MOV [pila + SI],BX	

	PUSH BX
	PUSH AX
	JMP exito
;FIN CASE 7 

case8 :
	CMP word ptr [tope], 0
	JL insufElems

	MOV AX, [pila + SI]
	NEG AX
	MOV [pila + SI], AX

	JMP exito
;FIN CASE 8

case9 : 
	CMP word ptr [tope], 0
	JL insufElems
	
	PUSH BX
	XOR BX,BX

	MOV AX, [pila+SI]
	CALL fact
	;En BX poseo el factorial
	MOV [pila+SI],BX ;Sustituyo el tope por su factorial
	POP BX
	JMP exito
;FIN CASE 9

case10 :
	CMP word ptr [tope], -2
	JLE sumaSinElems

	PUSH BX ;Guardo lo que haya previamente 
	PUSH CX
	MOV CX, 0 ;CX será el acumulador de la suma de los elementos, inicializado en 0
	MOV BX, [tope]
	JMP sum
;FIN CASE 10

case11 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta
	JL insufElems	

	PUSH BX ;Me aseguro de no perder lo que haya en BX.
		
	MOV BX, [pila + SI]
	SUB SI, 2
	SUB word ptr[tope], 2
	ADD BX, [pila + SI]
	MOV [pila +SI], BX 
	POP BX	

	JMP exito 
	
;FIN CASE 11

case12 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH BX ;Me aseguro de no perder lo que haya en BX.
	MOV SI, word ptr [tope]	

	MOV BX, [pila + SI]
	SUB SI, 2
	SUB [pila + SI], BX	

	SUB word ptr[tope], 2
	POP BX	

	JMP exito 
;FIN CASE 12		

case13 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH AX ;Me aseguro de no perder lo que haya en AX.
	PUSH BX		
	PUSH DX 

	MOV AX, [pila + SI]
	SUB SI, 2
	MOV BX, [pila + SI]
	MUL BX
	MOV [pila +SI], AX
	SUB word ptr[tope], 2
	
	POP DX
	POP BX
	POP AX	

	JMP exito 
;FIN CASE 13

case14 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH AX ;Me aseguro de no perder lo que haya en AX.
	PUSH BX		
	PUSH DX
	XOR DX,DX

	MOV BX, [pila + SI]
	SUB SI, 2
	MOV AX, [pila + SI] ;En AX pongo lo que esté en el tope-1
	
	CMP AX,0
	JL divisionNegativa	

	IDIV BX ;Esto pone en AX AX Div BX,entera LO QUE HAYA EN BX, ES DECIR, lo que esté en el tope(sin restar). IDIV porque DIV da problemas con el signo
	MOV [pila +SI], AX ;En AX queda el cociente
	SUB word ptr[tope], 2
	
	POP DX
	POP BX
	POP AX	

	JMP exito

;FIN CASE 14

case15 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH AX ;Me aseguro de no perder lo que haya en AX.
	PUSH BX		
	PUSH DX
	XOR DX,DX

	MOV BX, [pila + SI]
	SUB SI, 2
	MOV AX, [pila + SI] ;En AX pongo lo que esté en el tope-1

	CMP AX,0
	JL moduloNegativo	
	
	IDIV BX ;Esto pone en DX AX MOD LO QUE HAYA EN BX, ES DECIR, lo que esté en el tope(sin restar). IDIV porque DIV da problemas con el signo
	MOV [pila +SI], DX
	SUB word ptr[tope], 2
	
	POP DX
	POP BX
	POP AX	

	JMP exito


;FIN CASE 15

case16 : 
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH BX ;Me aseguro de no perder lo que haya en BX.
		
	MOV BX, [pila + SI]
	SUB SI, 2
	AND BX, [pila + SI]
	MOV [pila +SI], BX
	SUB word ptr[tope], 2
	POP BX	

	JMP exito 

;FIN CASE 16

case17 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH BX ;Me aseguro de no perder lo que haya en BX.
		
	MOV BX, [pila + SI]
	SUB SI, 2
	OR BX, [pila + SI]
	MOV [pila +SI], BX
	SUB word ptr[tope], 2
	POP BX	
	
	JMP exito 
;fin case 17

case18 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH CX ;Me aseguro de no perder lo que haya en CX.

	MOV CX, [pila + SI]
	SUB SI, 2
	SUB word ptr[tope], 2

	;Ahora, tengo el caso borde de si el shifteado es mayor a 16, en este caso debe dar 0 el resultado.
	CMP CX, 16
	JG shifteoIzqSup

	;En otro caso se realiza la operación normalmente
	SAL word ptr [pila +SI], CL

	POP CX	

	JMP exito 
;FIN CASE 18

case19 :
	CMP word ptr [tope], 0
	JE desapiloPorFalta ;Si el tope es 0, desapilo el elemento que ten
	JL insufElems

	PUSH CX ;Me aseguro de no perder lo que haya en CX.

	MOV CX, [pila + SI]
	SUB SI, 2
	SUB word ptr[tope], 2 ;SI y el tope "se mueven juntos"

	;En el caso del shifteo negativo se distinguen dos casos.
	;1) Si el número a shiftear es negativo, shifteando más de 16 posiciones el resultado es -1
	;2) Si el número a shiftear es positivo, shifteando más de 16 posiciones el resultado es 0
	CMP CX, 16
	JG shifteoDerSup

	;En otro caso se realiza la operación normalmente
	SAR word ptr [pila +SI], CL

	POP CX	

	JMP exito 
;FIN CASE 19

case254 :
	MOV SI, -2
	MOV word ptr [tope], -2
	JMP exito

case255 :
	;Debo indicar que la operación se realizó con exito
	PUSH DX
	MOV DX, [puertoSalidaBit] ;
	PUSH AX
	MOV AX, 16
	OUT DX, AX
	POP AX
	POP DX
	JMP END ;El loop END simboliza el fin del programa
;FIN CASE 255

	
;-------------------------FUNCIONES AUXILIARES--------------------------
END:
	JMP END

cicloDump:
	PUSH DX
	MOV DX, [puertoSalida]
	PUSH AX
	MOV AX, [pila+BX]

	OUT DX, AX
	POP AX
	POP DX
	SUB BX,2 ;En BX tengo el tope

	CMP BX, 0 ;Mientras el tope >= 0, itero
	JGE cicloDump
	
	POP BX 
;Si ya no cumplo la condición del while
	JMP exito
;FIN cicloDump
fact PROC
	CMP AX,0
	JE casoBase
	DEC AX
	CALL fact ;paso recursivo.
	INC AX
	MOV CX, AX
	MUL BX
	MOV BX, AX

	MOV AX, CX 
	JMP fin
	
	casoBase:
		MOV BX, 1
	fin:
		ret
fact ENDP

sum:
	ADD CX, [pila + BX]	
	SUB BX, 2	

	CMP BX, 0 ;Mientras el tope >= 0, itero
	JGE sum

;Si ya no cumplo la condicion del while
	MOV word ptr[tope], 0
	MOV SI, [tope]
	MOV [pila + SI], CX
	POP CX
	POP BX
	JMP exito


sumaSinElems :
	ADD word ptr [tope], 2	
	MOV SI, word ptr [tope]
	MOV word ptr [pila + SI], 0 ;Tenemos la condición de dejar 0 si no hay elementos.
	JMP exito
;	
insufElems:
	PUSH DX
	MOV DX, [puertoSalidaBit]
	PUSH AX
	MOV AX, 8
	OUT DX,  AX
	POP AX
	POP DX
	JMP esperarCodigo	

desbordada: ;En caso de que la operación haya fallado por desbordamiento de la pila, accedo a esta parte.

	IN AX, ENTRADA ;Pues cuando desbordo debo además, ignorar el elemento desbordado.
	PUSH DX
	MOV DX, [puertoSalidaBit]
	OUT DX, AX
	POP DX

	PUSH DX
	MOV DX, [puertoSalidaBit]
	PUSH AX
	MOV AX, 4
	OUT DX,  AX
	POP AX
	POP DX

	JMP esperarCodigo	

desbordadaYNoEsperoSalida:
	PUSH DX
	MOV DX, [puertoSalidaBit]
	PUSH AX
	MOV AX, 4
	OUT DX,  AX
	POP AX
	POP DX
	;Este caso es diferente a cuando se desborda por apilamiento. Pues cuando duplico el elemento del tope no espero otra entrada.
	JMP esperarCodigo	

exito: ;En caso de que la operación haya sido exitosa accedo a esta parte.
	PUSH DX
	MOV DX, [puertoSalidaBit] 
	PUSH AX
	MOV AX, 16
	OUT DX, AX
	POP AX
	POP DX
	JMP esperarCodigo

apilar: 
	IN AX, ENTRADA ;Recibo el número a apilar
	;Muestro la variable apilada
	PUSH DX
	MOV DX, [puertoSalidaBit]
	OUT DX, AX
	POP DX
	;
	ADD word ptr [tope], 0x0002 ;tope++
	MOV SI, word ptr [tope] ;SI contiene el valor del tope
	MOV [pila+SI], AX
	JMP exito


desapiloPorFalta: 
	SUB word ptr [tope], 0x0002 ;tope--
	MOV SI, word ptr [tope]
	JMP insufElems	

divisionNegativa :
	MOV DX, 0xFFFF
	IDIV BX ;Esto pone en AX AX Div BX,entera LO QUE HAYA EN BX, ES DECIR, lo que esté en el tope(sin restar). IDIV porque DIV da problemas con el signo
	MOV [pila +SI], AX ;En AX queda el cociente
	SUB word ptr[tope], 2
	
	POP DX
	POP BX
	POP AX	
	JMP exito

moduloNegativo :
	MOV DX, 0xFFFF
	IDIV BX ;Esto pone en DX AX mod BX,entera LO QUE HAYA EN BX, ES DECIR, lo que esté en el tope(sin restar). IDIV porque DIV da problemas con el signo
	MOV [pila +SI], DX ;En AX queda el cociente
	SUB word ptr[tope], 2
	
	POP DX
	POP BX
	POP AX	
	JMP exito

shifteoIzqSup:
	MOV CX, 0
	MOV [pila + SI], CX 
	POP CX
	JMP exito

shifteoDerSup:
	CMP word ptr[pila + SI], 0
	JL shiftDerSupNeg ;Caso 1)
	
	MOV CX, 0 ;Caso 2)
	MOV [pila + SI], CX
	POP CX
	JMP exito
			
shiftDerSupNeg:
	MOV CX, -1
	MOV [pila + SI], CX
	POP CX
	JMP exito

.ports 
ENTRADA: 

.interrupts ; Manejadores de interrupciones

