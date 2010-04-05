/* TDA STACK (stack.c) */
#include <stdlib.h>
#include <memory.h>
#include "stack.h"

int tda_stack_crear(tda_stack *stack, int tamano_dato)
/*
 * Primitiva que crea el stack, dejandolo listo para su uso.
 *
 * Precondiciones:  El stack no esta creado.
 * Postcondiciones: Stack creado y vacio.
 */

{
 /* inicializacion del puntero al tope */	
 stack->tope_stack=NULL;
 /* guardado del tamaño del dato */	
 stack->tamano_dato=tamano_dato;
 return(TRUE);
}

int tda_stack_push(tda_stack *stack, void *elemento_stack) 
/*
 * Primitiva que inserta un elemento en el tope del stack. Si no hay memoria suficiente devuelve FALSE.
 *
 * Precondiciones:  El stack esta creado.
 * Postcondiciones: El elemento recibido mediante "elemento_stack" es el nuevo tope.
 */

{
 t_nodo_stack *nodo_stack;
	
 /* asignacion de memoria para el nuevo nodo */	
 nodo_stack=(t_nodo_stack*)malloc(sizeof(t_nodo_stack));
 /* no pudo reservar memoria */
 if(nodo_stack==NULL) return(FALSE);
 
 /* asignacion de memoria para el elemento */
 nodo_stack->elemento_stack=malloc(stack->tamano_dato); 
 if(nodo_stack->elemento_stack==NULL) /* no pudo reservar memoria */
 {
  free(nodo_stack); /* liberacion de memoria reservada para el nodo */
  return(FALSE);
 }

 /* copia del elemento contenido en "elemento_stack" al nuevo nodo */
 memcpy(nodo_stack->elemento_stack,elemento_stack,stack->tamano_dato);

 /* asignacion de punteros */
 nodo_stack->siguiente=stack->tope_stack;
 stack->tope_stack=nodo_stack;

 return(TRUE);
}

int tda_stack_pop(tda_stack *stack, void *elemento_stack)
/*
 * Primitiva que saca el elemento localizado en el tope de un stack. Si la operacion fracasa (stack vacio), devuelve TRUE.
 *
 * Precondiciones:  El stack esta creado.
 * Postcondiciones: El elemento previamente localizado en el tope se devuelve en "elemento_stack".
 */

{
 t_nodo_stack *nodo_stack_auxiliar;

 /* el stack esta vacio */	
 if(stack->tope_stack==NULL)
  return FALSE;

 /* copia del elemento tope a "elemento_stack" */
 memcpy(elemento_stack,stack->tope_stack->elemento_stack,stack->tamano_dato);

 /* asignacion de punteros */
 nodo_stack_auxiliar=stack->tope_stack;
 stack->tope_stack=nodo_stack_auxiliar->siguiente;
 
 /* liberacion de memoria del elemento */
 free(nodo_stack_auxiliar->elemento_stack);
 /* liberacion de memoria del nodo */
 free(nodo_stack_auxiliar);

 return(TRUE);
}

/* FIN TDA STACK (stack.c) */
