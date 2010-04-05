/* TDA STACK (stack.h) */
#ifndef __STACK_H__
  #define __STACK_H__

    #define FALSE 0
    #define TRUE  1

    typedef struct t_nodo_stack
     {
      struct t_nodo_stack *siguiente;
      void *elemento_stack;
     } t_nodo_stack;

    typedef struct
     {	
      t_nodo_stack *tope_stack;
      int tamano_dato;
     } tda_stack;


    int tda_stack_crear(tda_stack *stack, int tamano_dato);
	/*
     * Primitiva que crea el stack, dejandolo listo para su uso.
     *
     * Precondiciones:  El stack no esta creado.
     * Postcondiciones: Stack creado y vacio.
     */
	 
    int tda_stack_push(tda_stack *stack, void *elemento_stack);
	/*
     * Primitiva que inserta un elemento en el tope del stack.
     *
     * Precondiciones:  El stack esta creado.
     * Postcondiciones: El elemento recibido mediante "elemento_stack" es el nuevo tope.
     */

    int tda_stack_pop(tda_stack *stack, void *elemento_stack);
	/*
     * Primitiva que saca el elemento localizado en el tope de un stack. Si la operacion fracasa (stack vacio), devuelve TRUE.
     *
     * Precondiciones:  El stack esta creado.
     * Postcondiciones: El elemento previamente localizado en el tope se devuelve en "elemento_stack".
     */

#endif

/* TDA STACK (stack.h) */
