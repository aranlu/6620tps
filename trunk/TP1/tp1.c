

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include "dconv.h"
float* y;


#define BUFFER_SIZE	10

typedef struct t_entrada{
	char *data;
	unsigned length;
	unsigned allocated;
	int index;
} t_entrada;

void imprimir_ayuda (FILE* stream, int exit_code){


  fprintf (stream,
		  "Uso:\n"
		  "  tp1 -h\n"
		  "  tp1 -V\n"
		  "  tp1 [options]\n"
		  "Options:\n"
          "  -V,  --version               Imprime la version y termina.\n"
          "  -h,  --help                  Imprime esta informacion y termina.\n"
          "  -r, --response               Nombre del archivo que especifica h[n].\n"
          "  -p, --pulse                  Pulso que representa h[n] entre dos valores de n.\n"
		  "Examples:\n"
		  "  tp1 -p \"[1 2]\"\n"
		  "  tp1 -p \"8*[1 2]\"\n"
		  "  echo -n \"1.4 2.5 3.0\"|tp1 -r r.data\n");
  exit (exit_code);
}

void imprimir_version(FILE* stream, int exit_code){

	fprintf (stream, "tp1: 1.0 \n");
	exit (exit_code);
}

/* check caracter

devuelve cantidad de vece que aparece en linea c

*/

int check_caracter(char* linea, char c){
	int count=0;
	int i=0;

	while(i<strlen(linea)){

	
		if(linea[i]==c) {

			count++;
			linea[i]=' ';

		};

		i++;

	}

return count;


}


/*push_back
devuelve:

+ 0 si no hubo error
+ 1 si no hay memoria.

*/


int push_back(float** vector,int* size, float f){

	
	float* aux;

	if(*vector==NULL){


		*vector = (float *) calloc( 1, sizeof(float) );
		if ( *vector == NULL ){
			
			return (1); /* no hay memoria*/
		}

		*size=1;
		(*vector)[0]=f;


	}else{

		aux=*vector;
		*vector = (float *) realloc(*vector, (*size + 1) * sizeof(float) );
		if ( *vector == NULL ){

				free(aux); 
				return(1); /*no hay memoria*/
			}
		*size += 1;
		(*vector)[*size-1] = f;


	}

	return 0;





}

/* armar_vector:

devuelve:
+ 0 si no hubo error
+ 1 si no hay memoria
+ 2 si la sintaxis es incorrecta */

int armar_vector(char* linea, float** vector,int* vsize){
int i,j;
int error;
i=0;
j=0;
error=0;
float nro;

char* acum = (char*) malloc((strlen(linea)+1)*sizeof(char));
acum[0]='\0';


while((i<strlen(linea))&&(!error)){


		if((isdigit((unsigned char)linea[i]))||(linea[i]=='-')||(linea[i]=='.')){
			acum[j]=linea[i];
			j++;
		}else if(linea[i]==' ') {

 					
				
			acum[j]='\0';
			nro=atof(acum);

			if(strcmp(acum,"")!=0){
			if((nro==0.0)&&(strcmp(acum,"0")!=0)&&(strcmp(acum,"0.0")!=0)) {

			error=2;

				}
				else{
					error=push_back(vector,vsize,nro);


				};

			};


			j=0;
			acum[0]='\0';

		}else {

			error=2;
			//caracteres invalidos


		}

							
		

		i++;

	}
free(acum);
return error;



}


int contieneAsterisco(char* parametros){

	int i=0;
	int encontrado=0;
	while((i<strlen(parametros))&&(!encontrado)){
	
		if(parametros[i]=='*') encontrado=1;
		

		i++;
	}

	return encontrado;


}


/*generar_pulso:
devuelve:

+ 0 si no hubo error
+ 1 si no hay memoria
+ 2 si la sintaxis del pulso ingresado es incorrecta o hay caracteres inválidos */


int generar_pulso(char* parametros, float** h, int* hsize){

	/* parseo los parámetros */

	float multiplicador;
	int desde;
	int hasta;
	int j;
	int i;
	int k;
	float nro;
	float ultimonro;
	int aleido;
	int ileido;
	int fleido;
	int nrosleidos;
	int error;

	nrosleidos=0;
	ultimonro=0;
	aleido=0;
	ileido=0;
	fleido=0;



	i=0;
	j=0;

	if(!contieneAsterisco(parametros)){

		multiplicador=1;
		aleido=1;
		nrosleidos++;


	};

	char* acum = (char*) malloc((strlen(parametros)+1)*sizeof(char));
	acum[0]='\0';

	error=0;



	while((i<strlen(parametros))&&(!error)){


		if((isdigit((unsigned char)parametros[i]))||(parametros[i]=='-')||(parametros[i]=='.')){
			acum[j]=parametros[i];
			j++;
		}else {

 					
				
			acum[j]='\0';
			nro=atof(acum);

			if(strcmp(acum,"")!=0){
			if((nro==0.0)&&(strcmp(acum,"0")!=0)&&(strcmp(acum,"0.0")!=0)) {
				error=2;
				}
				else{
					ultimonro=nro;
					nrosleidos++;
				};

			};


			j=0;
			acum[0]='\0';

			switch(parametros[i]){

				case '*':
					if(aleido) {

						error=2;
					}else{				
					aleido=1;
					if((!ileido)&&(!fleido)&&(nrosleidos==1)) multiplicador=ultimonro;
					else {
						error=2;
						};
					}

				break;

				case '[':

					if(ileido){

						error=2;
		

					}else{

					ileido=1;
					if((!aleido)&&(nrosleidos==0)){	}
					else if ((aleido)&&(nrosleidos==1)){} 
					else {

						error=2;
					
					}
					};

				break;

				case ']':

					if(fleido){

						error=2;


					}else{
					fleido=1;
					if((aleido)&&(ileido)&&(nrosleidos==3))	hasta=ultimonro;
					else if((!aleido)&&(ileido)&&(nrosleidos==2)) hasta=ultimonro;						

					else{

					error=2;
					}
					};

				break;


				case ' ':
				
				if((aleido)&&(ileido)&&(nrosleidos==2)){
					desde=ultimonro;
				
				}else if((!aleido)&&(ileido)&&(nrosleidos==1)){


					desde=ultimonro;

				}

				break;
				default:

					error=2;

				break;

			}



			};




					
		

		i++;

	}

if(!error){

	if((!ileido)||(!fleido)) error=2;

}


if(!error){
	k=desde;
	while((k<hasta+1)&&(!error)){

		error=push_back(h,hsize,multiplicador);
		k++;


	};



};
free(acum);
return (error);


}

/* check_order

devuelve:

+ 0 si no hay error de orden.
+ 2 si ] está antes de [ */

int check_order(char* l){
	int counti=0;
	int i=0;
	int error=0;


	while((i<strlen(l))&&(!error)){

		if(l[i]=='[') counti++;
		if(l[i]==']'){

			if(counti==0)
			error=2;
			



			}
		


	

		i++;

	}

return error;


}


int check_sintax(t_entrada* e){

	int ileido=0;
	int fleido=0;
	int error=0;

	int i=0;

	while(i<strlen(e->data)){

		switch(e->data[i]){

		case '[':

			if(!ileido) ileido=1;
			else error=1;
			if(fleido) error=1;
			e->data[i]=' ';

			break;
		case ']':
			if(!ileido) error=1;
			if(fleido) error=1;
			e->data[i]=' ';
			fleido=1;

			break;

		case ' ':

			break;
		default:

			if(!ileido) error=1;
			if(fleido) error=1;
			break;





		}	

		

		i++;

	};

if((!ileido)||(!fleido)) error=1;	

return error;






}


int init(t_entrada* datosEntrada){

 datosEntrada->data = (char *) calloc( BUFFER_SIZE + 1, sizeof(char) );
        if ( datosEntrada->data == NULL ){
//                fprintf(stderr, "ERROR: No hay memoria suficiente para comenzar el procesamiento...\n");
                return (1);
        }
        datosEntrada->length = 0;
        datosEntrada->allocated = BUFFER_SIZE;
	datosEntrada->index=0;

	return 0;



}


int destroy(t_entrada* datosEntrada){

	if(datosEntrada->data!=NULL){

        free(datosEntrada->data);
	datosEntrada->length=0;
	datosEntrada->allocated=0;
	datosEntrada->index=0;
	}else return 1;

	return 0;



}



/* leerEntrada:

PRE: datosEntrada ya fue creado con init

devuelve:

+ 0 si se pudo leer correctamente desde el stream.
+ 1 si no hay memoria para continuar
+ 2 si ocurre un error de sintaxis*/



int leerEntrada(FILE* stream, t_entrada* datosEntrada ){




//        t_entrada datosEntrada;
        char* aux;
        char currentChar;
//        int index=0;
	int error=0;


//        datosEntrada.data = (char *) calloc( BUFFER_SIZE + 1, sizeof(char) );
 //       if ( datosEntrada.data == NULL ){
//                fprintf(stderr, "ERROR: No hay memoria suficiente para comenzar el procesamiento...\n");
//                return (1);
 //       }
   //     datosEntrada.length = 0;
     //   datosEntrada.allocated = BUFFER_SIZE;

        do{
                currentChar=fgetc(stream);
	
                if ( datosEntrada->length == datosEntrada->allocated ){
                        aux=datosEntrada->data; 
                        datosEntrada->data = (char *) realloc(datosEntrada->data, (BUFFER_SIZE * ((datosEntrada->length / BUFFER_SIZE) + 1)) * sizeof(char) );
                        if ( datosEntrada->data == NULL ){
  //                            fprintf(stderr, "ERROR: No hay memoria suficiente para continuar el procesamiento...\n");
                                free(aux);
                                aux=NULL;
                                return(1);
                        }
                        datosEntrada->allocated += BUFFER_SIZE;
                }
                switch (currentChar){

			case '\n':{
                               

                                break;
                        }
                        case EOF:{


				//datosEntrada.data[index] = '\0';
				//error=0;

				/*if(!*ileido) {


				error=check_order(datosEntrada.data);
				}

				if(!error){
					if(!(*ileido)) *ileido=check_caracter(datosEntrada.data,'[');
					*fleido=check_caracter(datosEntrada.data,']');
					error=armar_vector(datosEntrada.data,h,hsize);

				}
                                */

/*                                free(datosEntrada.data);


                                datosEntrada.data = (char *) calloc( BUFFER_SIZE + 1, sizeof(char) );
                                if ( datosEntrada.data == NULL ){
                                        fprintf(stderr, "ERROR: No hay memoria suficiente para continuar el procesamiento...\n");
                                        return (1);
                                }
                                datosEntrada.length = 0;
                                datosEntrada.allocated = BUFFER_SIZE;
                                index = 0;*/
                                break;
                        }
                        default:{
                                datosEntrada->data[datosEntrada->index] = currentChar;
                                (datosEntrada->index)++;
                                datosEntrada->length++;
                        }
                }
                fflush(stdout);
        }
        while ((currentChar!= EOF)&&(!error));
//        free(datosEntrada.data);




return 0;
//        return (error);
}

/* leer_archivo:

devuelve:

+ 0 si no hubo error
+ 1 si no hay memoria para leer el archivo
+ 2 si hubo error de sintaxis
+ 3 si no se pudo abrir el archivo*/


int leer_archivo(char* nombre,t_entrada* entrada){

	int res;



	FILE* a=fopen(nombre,"r");

	if(!a) return 3;
	res=leerEntrada(a,entrada)	;
	fclose(a);


	return res;

} 




int main(int argc, char** argv){


float* h=NULL;
float* x=NULL;
int hsize;
int xsize;

t_entrada entradah;
t_entrada entradax;

init(&entradah);
init(&entradax);

int ileido,fleido;
int error=0;
int i;

ileido=0;
fleido=0;

int pulso=0;
int archivo=0;
int errors=0;

int opcion;
const char* const short_options = "hVr:p:";

	const struct option long_options[] =
	{
		{ "help", 0, NULL, 'h' },
		{ "version", 0, NULL, 'V' },
		{ "response", 1, NULL, 'r' },
		{ "pulse", 1, NULL, 'p' },
		{ NULL, 0, NULL, 0 }
	};

	int lista_archivos=0;
	int res;
	int opt=0;


	if(argc==1)
		fprintf(stderr,"Error: Falta especificar una opción.");
	else
	{
		do {
			opcion = getopt_long (argc, argv, short_options, long_options, NULL);
			switch (opcion)
			{
			    case 'h':   /* -h o --help */
			    	imprimir_ayuda (stdout, 0);
			    	opt=1;
			    	break;
			    case 'r':   /* -r o --response */
				if((!pulso)&&(!archivo)){
			    	lista_archivos=1;
			    	res=leer_archivo(optarg,&entradah);
//				if(ileido>1) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta o hay caracteres inválidos. \n",optarg);
//				if(fleido>1) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta o hay caracteres inválidos. \n",optarg);
//				if((fleido>=1)&&(ileido==0)) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta.\n",optarg);
			    	if(res==3) fprintf(stderr,"ERROR: No se pudo abrir el archivo %s.\n",optarg);
//			    	if(res==2) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta o hay caracteres inválidos.\n",optarg);
			    	if(res==1) fprintf(stderr,"ERROR: No hay memoria suficiente para continuar.\n");
			    	opt=1;
				archivo=1;
				} else{


					errors=1;


				};
			    	break;
			    case 'p':   /* -p o --pulse */

				if((!pulso)&&(!archivo)){
				res=generar_pulso(optarg,&h,&hsize);
			    	if(res==1) fprintf(stderr,"ERROR: No hay memoria suficiente para continuar.\n");
			    	if(res==2) fprintf(stderr,"ERROR: la sintaxis del pulso ingresado es incorrecta.\n");



			    	opt=1;
				ileido=1;
				fleido=1;

				pulso=1;

				} else{



					errors=1;
	

				}
			    	break;
			    case 'V':   /* -V o --version */
			    	imprimir_version (stdout, 0);
			    	opt=1;
			    	break;
			    case '?':  /*error*/
			    	fprintf(stderr,"ERROR: La opción no existe.\n");
			    	imprimir_ayuda (stderr, 1);
			    	opt=1;
			    case -1:
					break;
			    case ':':
			    	fprintf(stderr,"ERROR: Faltan argumentos.\n");
			    	imprimir_ayuda (stderr, 1);
			    	break;
			    default:
			    	break;
			}
		} while((opcion != -1));

		if((!opt)&&(argc>1))
			fprintf(stderr,"ERROR: Falta especificar una opción.");

		if(lista_archivos)
		{
		    for (i = optind; i < argc; ++i)

		    {


			    	res=leer_archivo(argv[i],&entradah); 
//				if(ileido>1) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta o hay caracteres inválidos. \n",optarg);
//				if(fleido>1) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta o hay caracteres inválidos. \n",optarg);
//				if((fleido>=1)&&(ileido==0)) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta. \n",optarg);
			    	if(res==3) fprintf(stderr,"ERROR: No se pudo abrir el archivo %s.\n",optarg);
//			    	if(res==2) fprintf(stderr,"ERROR: la sintaxis del archivo %s es incorrecta o hay caracteres inválidos.\n",optarg);
			    	if(res==1) fprintf(stderr,"ERROR: No hay memoria suficiente para continuar.\n");
			



			}

		}


	}

if(errors){
	fprintf(stderr,"ERROR: las opciones ingresadas son incorrectas.\n");

	destroy(&entradah);
	destroy(&entradax);
	return 1;

	};

entradah.data[entradah.index]='\0';


res=check_sintax(&entradah);

if(res==0) error=armar_vector(entradah.data,&h,&hsize);
else if(!pulso)fprintf(stderr,"ERROR: la sintaxis de h es incorrecta.\n");

if(!pulso){
if(error==1) fprintf(stderr,"ERROR: no hay memoria suficiente para continuar.\n ");
if(error==2) fprintf(stderr,"ERROR: hay caracteres inválidos en el vector h.\n ");

}

destroy(&entradah);



if(h==NULL){

	/* no hay h , no se puede hacer nada*/
	return 1;


}

if(!pulso)
if((error)||(res!=0)) return 1;

/* leo x desde stdin */;

ileido=0;
fleido=0;
error=leerEntrada(stdin,&entradax);
entradax.data[entradax.index]='\0';



res=check_sintax(&entradax);
if(res==0) error=armar_vector(entradax.data,&x,&xsize);
else fprintf(stderr,"ERROR: la sintaxis de x es incorrecta.\n");

destroy(&entradax);
if(error==1) fprintf(stderr,"ERROR: no hay memoria suficiente para continuar.\n ");
if(error==2) fprintf(stderr,"ERROR: hay caracteres inválidos en el vector x.\n ");




if(x==NULL){
	/*no tengo x, no puedo ahcer nada*/
	if(h!=NULL){
		/*libero h*/

		free(h);
		return 1;

	}


}

if((error)||(res!=0)) return 1;



/* tengo h y x*/

if((!errors)&&(!error)){
/*no hay error de sintaxis: -r y -p*/

i=0;

/* si x tiene menos elementos que h, repito x*/
if(xsize<hsize){

	while(xsize<hsize){

		push_back(&x,&xsize,x[i]);
		i++;
	
	};
	



}


/* reservo espacio para y, xsize + hsize -1 */

y=(float*)malloc((xsize+hsize-1)*sizeof(float));


if(y!=NULL){

/* LLAMAR A CONVOLUCIÓN*/

conv(x,xsize,h,hsize);

};

/*imprimo y*/

printf("%s","[ ");

for(i=0;i<xsize+hsize-1;i++){


	printf("%.2f ",y[i]);


}

printf("%s","]\n");



/* LIBERO Y*/

if(y!=NULL)
free(y);


}


/*
printf("\n\n X es:");
i=0;
while(i<xsize){


printf(" %f \n",x[i]);

i++;
}

i=0;

printf("\n\n h es:");
while(i<hsize){


printf(" %f \n",h[i]);

i++;
}
*/



/*LIBERO H y X*/
if(h!=NULL)
free(h);

if(x!=NULL)
free(x);











return 0;

}


