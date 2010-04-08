/*
 *------------------------------------------------------------------------------
 *
 *                      66.20 - ORGANIZACION DE COMPUTADORAS
 *                          TP0: Infraestructura basica
 *
 *------------------------------------------------------------------------------
 *
 * Grupo 5:
 * 79979 - Gonzalez, Juan Manuel (juan0511@yahoo.com)
 * 86326 - Smocovich, Elizabeth (liz.smocovich@gmail.com)
 * 88816 - Pereira, Maria Florencia (mflorenciapereira@gmail.com)
 *
 * Fecha de entrega: 18/03/2010
 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

#include "stack.h"


#define BUFFER_SIZE	10

typedef struct t_entrada{
	char *data;
	unsigned length;
	unsigned allocated;
} t_entrada;

typedef struct
{
	double valor;
} t_elemento_stack;

void imprimir_ayuda (FILE* stream, int exit_code){

  fprintf (stream,
		  "Uso:\n"
		  "  tp0 -h\n"
		  "  tp0 -V\n"
		  "  tp0 [options]\n"
		  "Options:\n"
          "  -V,  --version               Version.\n"
          "  -h,  --help                  Ayuda.\n"
          "  -f,  --scriptfile scrptfile  Ejecuta los comandos especificados en el scriptfile.\n"
          "  -e,  --script script         Ejecuta los comandos en el script.\n"
		  "Examples:\n"
		  "  tp0\n"
		  "  tp0 -e\"22+5*p\"\n"
		  "  tp0 -f calculo.m\n");
  exit (exit_code);
}

void imprimir_version(FILE* stream, int exit_code){

	fprintf (stream, "TP0: 1.0 \n");
	exit (exit_code);
}

void destruir_stack(tda_stack *stack){

	t_elemento_stack elemento_stack;
	while(tda_stack_pop(stack,&elemento_stack)==TRUE);
}

void ejecutar(char* script, tda_stack* pila){

	char* acum = (char*) malloc((strlen(script)+1)*sizeof(char));
	int i;
	int j;
	double nro;
	double a, b,c;
	int res;

	strcpy(acum,"");
	strcat(script," ");
	i=0;
	j=0;

	while(i<strlen(script)){
		if(isdigit(script[i])){
			acum[j]=script[i];
			j++;
		}
		else if(script[i]=='_'){
				acum[j]='-';
				j++;
			}else if(script[i]=='.'){
					acum[j]='.';
					j++;
				}else{
					acum[j]='\0';
					nro=atof(acum);

					if(strcmp(acum,"")!=0){
						if((nro==0.0)&&(strcmp(acum,"0")!=0)) fprintf(stderr, "ERROR: Caracteres invalidos.\n") ;
						else{
							tda_stack_push(pila,&nro);
						}
					};
				j=0;
				switch(script[i]){

					case '+': /*SUMA*/
						res=tda_stack_pop(pila,&a);
						if(res){
							res=tda_stack_pop(pila,&b);
							if(res){
								c=a+b;
								tda_stack_push(pila,&c);
							}else fprintf(stderr, "ERROR: No hay segundo operando.\n");
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;

					case '-': /* RESTA*/
						res=tda_stack_pop(pila,&a);
						if(res){
							res=tda_stack_pop(pila,&b);

							if(res){
								c=a-b;
								tda_stack_push(pila,&c);
							}else fprintf(stderr, "ERROR: No hay segundo operando.\n");
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;

					case '*': /*MULTIPLICACION*/
						res=tda_stack_pop(pila,&a);
						if(res){
							res=tda_stack_pop(pila,&b);
							if(res){
								c=a*b;
								tda_stack_push(pila,&c);
							}else fprintf(stderr, "ERROR: No hay segundo operando.\n");
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;

					case '%': /*RESTO*/
						res=tda_stack_pop(pila,&a);
						if(res){
							res=tda_stack_pop(pila,&b);
							if(res){
								c=(int)a % (int)b;
								tda_stack_push(pila,&c);
							}else fprintf(stderr, "ERROR: No hay segundo operando.\n");
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;

					case '/': /*DIVISION*/
						res=tda_stack_pop(pila,&a);
						if(res){
							res=tda_stack_pop(pila,&b);
							if(res){
								if(b!=0){
									c=a/b;
									tda_stack_push(pila,&c);
								}else fprintf(stderr, "ERROR: Division por 0.\n");
							}else fprintf(stderr, "ERROR: No hay segundo operando.\n");
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;

					case 'f': /* vacia la pila e imprime contenido*/
						res=tda_stack_pop(pila,&a);
						if(!res) fprintf(stderr, "ERROR: Pila vacia.\n ");
						while(res){
							printf("%.8f\n",a);
							res=tda_stack_pop(pila,&a);
						};
					break;

					case 'p': /*imprimer el primer valor, sin alterar la pila. Imprime \n */
						res=tda_stack_pop(pila,&a);
						if(res){
							printf("%.8f\n",a);
							tda_stack_push(pila,&a);
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;

					case 'n': /*toma tope de la pila e imprime. no agrega \n*/
						res=tda_stack_pop(pila,&a);
						if(res) printf("%.8f",a);
						else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;

					case 'v': /* sqrt del tope */
						res=tda_stack_pop(pila,&a);
						if(res){
							b=sqrt (a);
							tda_stack_push(pila,&b);
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;
	
					case 'c': /*vaciar pila*/
						res=tda_stack_pop(pila,&a);
						if(!res) fprintf(stderr, "ERROR: Pila vacia.\n");
						destruir_stack(pila);
					break;
	
					case 'd': /*duplicar el valor en la cima */
						res=tda_stack_pop(pila,&a);
						if(res){
							tda_stack_push(pila,&a);
							tda_stack_push(pila,&a);
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;
	
					case 'r': /*invierte el orden del primer y segundo elemento de la pila */
						res=tda_stack_pop(pila,&a);
						if(res){
							res=tda_stack_pop(pila,&b);
							if(res){
								tda_stack_push(pila,&a);
								tda_stack_push(pila,&b);
							}else {
								tda_stack_push(pila,&a);
								fprintf(stderr, "ERROR: Hay un unico elemento en la pila.\n");
							};
						}else fprintf(stderr, "ERROR: Pila vacia.\n");
					break;
	
					case ' ':
					break;
	
					case '\n':
					break;

					default:
						fprintf(stderr, "ERRROR: '%c' no implementado.\n",script[i]);
					break;
				}
			}
		i++;
	};
	free(acum);
}



int leerEntrada(FILE* stream, tda_stack* pila){

	t_entrada datosEntrada;
	char* aux;
	char currentChar;
	int index=0;

	datosEntrada.data = (char *) calloc( BUFFER_SIZE + 1, sizeof(char) );
	if ( datosEntrada.data == NULL ){
		fprintf(stderr, "ERROR: No hay memoria suficiente para comenzar el procesamiento...\n");
		return (EXIT_FAILURE);
	}
	datosEntrada.length = 0;
	datosEntrada.allocated = BUFFER_SIZE;

	do{
		currentChar=fgetc(stream);
		if ( datosEntrada.length == datosEntrada.allocated ){
			aux=datosEntrada.data; 
			datosEntrada.data = (char *) realloc(datosEntrada.data, (BUFFER_SIZE * ((datosEntrada.length / BUFFER_SIZE) + 1)) * sizeof(char) );
			if ( datosEntrada.data == NULL ){
				fprintf(stderr, "ERROR: No hay memoria suficiente para continuar el procesamiento...\n");
				free(aux);
				aux=NULL;
				return(EXIT_FAILURE);
			}
			datosEntrada.allocated += BUFFER_SIZE;
		}
		switch (currentChar){
			case '\n':{
				datosEntrada.data[index] = '\0';
				
 				ejecutar(datosEntrada.data,pila);
				free(datosEntrada.data);

				datosEntrada.data = (char *) calloc( BUFFER_SIZE + 1, sizeof(char) );
				if ( datosEntrada.data == NULL ){
					fprintf(stderr, "ERROR: No hay memoria suficiente para continuar el procesamiento...\n");
					return (EXIT_FAILURE);
				}
				datosEntrada.length = 0;
				datosEntrada.allocated = BUFFER_SIZE;
				index = 0;

				break;
			}
			case EOF:{
				break;
			}
			default:{
				datosEntrada.data[index] = currentChar;
				index++;
				datosEntrada.length++;
			}
		}
		fflush(stdout);
	}
	while ((currentChar!= EOF));
	free(datosEntrada.data);

	return (EXIT_SUCCESS);
}


int ejecutar_desde_archivo(char* nombre,tda_stack* pila){

	int res;


	FILE* a=fopen(nombre,"r");

	if(!a) return 1;
	res=leerEntrada(a,pila)	;
	fclose(a);

	return res;

} 

int main(int argc, char* argv[])
{
	tda_stack pila;
	int opcion;
	char script[2];
	int i=0;


	const char* const short_options = "hVf:e:";

	const struct option long_options[] =
	{
		{ "help", 0, NULL, 'h' },
		{ "version", 0, NULL, 'V' },
		{ "scriptfile", 1, NULL, 'f' },
		{ "script", 1, NULL, 'e' },
		{ NULL, 0, NULL, 0 }
	};

	int lista_archivos=0;
	int res;
	int opt=0;

	tda_stack_crear(&pila, sizeof(double));
	strcpy(script,"");

	if(argc==1)
		return (leerEntrada(stdin,&pila));
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
			    case 'f':   /* -f o --scriptfile */
			    	lista_archivos=1;
				
			    	res=ejecutar_desde_archivo(optarg,&pila); 
			    	if(res==1) fprintf(stderr,"ERROR: No se pudo abrir el archivo %s.\n",optarg);
			    	opt=1;
			    	break;
			    case 'e':   /* -e o --script */
				ejecutar(optarg,&pila);

			    	opt=1;
			    	break;
			    case 'V':   /* -V o --version */
			    	imprimir_version (stdout, 0);
			    	opt=1;
			    	break;
			    case '?':  /*error*/
			    	imprimir_ayuda (stderr, 1);
			    	opt=1;
			    case -1:
					break;
			    case ':':
			    	fprintf(stderr,"ERROR: Faltan argumentos.\n");
			    	break;
			    default:
			    	break;
			}
		} while(opcion != -1);

		if((!opt)&&(argc>1))
			ejecutar(argv[1],&pila);

		if(lista_archivos)
		{
		    for (i = optind; i < argc; ++i)
		    {
		    	res=ejecutar_desde_archivo(argv[i],&pila); 
		     	if(res==1) fprintf(stderr,"ERROR: No se pudo abrir el archivo %s.\n",argv[i]);
			}
		}

		ejecutar(script,&pila);
	}

	destruir_stack(&pila);

	return (EXIT_SUCCESS);
}
