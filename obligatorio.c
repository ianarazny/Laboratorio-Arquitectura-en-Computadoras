//Aquí definiría los puertos por defecto:
#include <stdio.h>


int main(){

#define PUERTO_SALIDA_DEFECTO 1;
#define PUERTO_LOG_DEFECTO 2;
int puertoSalida = PUERTO_SALIDA_DEFECTO;
int puertoSalidaBit = PUERTO_LOG_DEFECTO;

int pila[31]; //El arreglo debe tener 31 espacios pues aceptamos hasta 31 operandos.
int tope=-1; //El tope me indica cuál es el último elemento utilizado en la pila.
//El tope me ayudará para la implementación de la pila. Indica cuál es la celda sin elementos.

    int nuevoPuerto;
    int nuevoPuertoBit;

do {
    out(puertoSalidaBit);
    printf("0");
    scanf("%d", &codigo);

    out(puertoSalidaBit);
    printf("%d", codigo);

    switch (codigo){
        case 1:
            case1(pila, tope);
            break;

        case 2:
            case2(pila, tope);
            break;
        
        case 3:
            case3(pila, tope);
            break;
        
        case 4:
            case4(pila, tope);
            break;

        case 5:
            case5(pila, tope);
            break;

        case 6:
            case6(pila, tope);
            break;
        
        case 7:
            case7(pila, tope);
            break;
        
        case 8:
            case8(pila, tope);
            break;
        
        case 9:
            case9(pila, tope);
            break;

        case 10:
            case10(pila, tope);
            break;

        case 11:
            case11(pila, tope);
            break;
        
        case 12:
            case12(pila, tope);
            break;

        case 13:
            case13(pila, tope);           
            break;

        case 14:
            case14(pila, tope);
            break;

        case 15:
            case15(pila, tope);
            break;

        case 16:
            case16(pila, tope);
            break;

        case 17:
            case17(pila, tope);
            break;

        case 18:
            case18(pila, tope);
            break;

        case 19:
            case19(pila, tope);
            break;
        
        case 254:
            case254(pila, tope);
            break;
        
        case 255:
            case255();
            break;

    default:
        out(puertoSalidaBit);
        printf("2\n");
        break;
    }
} while(codigo!=255);

    return 0;
}

//Funciones auxiliares:
int fact(int n){
    if(n==0)
        return 1;
    else
        return n*fact(n-1);
}

int sum(int *pila, int max){
    int i=0;
    int res=0;
    while(i<max)
        res= res + pila[i];
    
    return res;
}

void exito(){
    printf("16");
}

void insufElems(){
    printf("8");
}
void desapiloPorFalta(){
    printf("8"):
    tope=-1;
}

void desbordada(){
    printf("4");
    scanf("%d",ignore);
}

void desbordadaYNoEsperoSalida(){
    printf("4");
}

void apilar(int *pila, int &topeAct){
    topeAct++;
    printf("Escriba un operando \n");
    scanf("%d", &num);
    pila[tope] = num;
    exito();
}

void cicloDump(int* pila, int tope){
    int i=0;
    while(i<=tope){
        printf("%i\n", pila[i]);
        i++;
    }
}

void out(int puerto){
    printf("Puerto %i:", puerto);
}



void case1(int *pila, int &tope){
    if(tope<=30){   
        apilar(pila,tope);
        out(puertoSalidaBit);
        exito();
    } else {
        out(puertoSalidaBit);
        desbordada();
    }
}
void case2(int *pila, int &tope){
    scanf("%d",&puertoSalida);
    puertoSalida = nuevoPuerto;

    out(puertoSalidaBit);
    exito();
}
void case3(int *pila, int &tope){
        
    scanf("%d", &nuevoPuertoBit);
    puertoSalidaBit = nuevoPuertoBit;
        
    out(puertoSalidaBit);
    exito();
            
}
void case4(int *pila, int &tope){
    if(tope<0)
        out(puertoSalidaBit);
        insufElems();
    else {
        out(puertoSalida);
        printf("%d", pila[tope]);
        exito();
    }
    
}
void case5(int *pila, int &tope){
    if(tope>=0){
        cicloDump(pila, tope);
    } 
    out(puertoSalida);
    exito();   
}
void case6(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();
    } else if(tope>=60){
        out(puertoSalidaBit);
        desbordadaYNoEsperoSalida();
    } else {
        pila[tope+1]= pila[tope]; 
        tope++;
        out(puertoSalidaBit);
        exito();
    }
}
void case7(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();
    } else if(tope=0){
        desapiloPorFalta();
    } else{
        int aux= pila[tope];
        tope--;
        int aux2= pila[tope];
        pila[tope] =aux;
        tope++;
        pila[tope] =aux2;
            
        out(puertoSalidaBit);
        exito();
    }        
}
void case8(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();
    } else {
        pila[tope] = pila[tope]*-1;
        out(puertoSalidaBit);
        exito();
    }        
}
void case9(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();
    } else {            
        pila[tope] = fact(pila[tope]);
        out(puertoSalidaBit);
        exito();
    }        
}
void case10(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();
    } else {
        int suma=sum(pila,tope);
        pila[0]=suma;
        out(puertoSalidaBit);
        exito();
    }
    tope=0;
}
void case11(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();
    } else if(tope==0){
            
        out(puertoSalidaBit);
        desapiloPorFalta();
    } else {
        pila[tope-1]= pila[tope-1] + pila[tope];
        tope=tope-1;
        out(puertoSalidaBit);
        exito();            
    }    
}
void case12(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();            
    } else if(tope==0){
        
        out(puertoSalidaBit);
        desapiloPorFalta();
    } else {
        pila[tope-1]=pila[tope-1] - pila[tope];
        tope--;
        out(puertoSalidaBit);
        exito();
    }    
}
void case13(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();            
    }  else if(tope==0){
        
        out(puertoSalidaBit);
        desapiloPorFalta();
    }else {

        pila[tope-1]=pila[tope-1] * pila[tope];
        tope--;
        out(puertoSalidaBit);
        exito();
    }         
}
void case14(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();             
    }  else if(tope==0){
        
        out(puertoSalidaBit);
        desapiloPorFalta();
    } else {
        
        pila[tope-1]=pila[tope-1] / pila[tope];
        tope--;
        out(puertoSalidaBit);
        exito();
    }    
}
void case15(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();            
        tope=-1
    }  else if(tope==0){

        out(puertoSalidaBit);
        desapiloPorFalta();
    } else {
        
        pila[tope-1]=pila[tope-1] % pila[tope];
        tope--;
        out(puertoSalidaBit);
        exito();
    }    
}    
void case16(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();            
    }  else if(tope==0){
            
        out(puertoSalidaBit);
        desapiloPorFalta()
    } else {
    
        pila[tope-1]=pila[tope-1] & pila[tope];
        tope--;
        out(puertoSalidaBit);
        exito();
    }
}
void case17(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();            
    } else if(tope==0){
        
        out(puertoSalidaBit);
        desapiloPorFalta();
    } else {
    
    pila[tope-1]=pila[tope-1] | pila[tope];
    tope--;
    out(puertoSalidaBit);
    exito();
    }    
}
void case18(int *pila, int &tope){
    if(tope<0){
    out(puertoSalidaBit);
    insufElems();            
    } else if(tope==0){
        
        out(puertoSalidaBit);
        desapiloPorFalta();
    } else {
    
    pila[tope-1]=pila[tope-1] << pila[tope];
    tope--;
    out(puertoSalidaBit);
    exito();
    }    
}
void case19(int *pila, int &tope){
    if(tope<0){
        out(puertoSalidaBit);
        insufElems();
    }  else if(tope==0){
    
        out(puertoSalidaBit);
        desapiloPorFalta();
    }else {
    
    pila[tope-1]=pila[tope-1] >> pila[tope];
    tope--;
    out(puertoSalidaBit);
    exito();
    }    
}
void case254(int *pila, int &tope){
    tope=-1;
    out(puertoSalidaBit);
    exito();
}

void case 255(){
    out(puertoSalidaBit);
    printf("16");
    end();
}

void end(){
    while(true){}
}
