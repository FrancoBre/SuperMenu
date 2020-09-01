#include <stdio.h>  //incluimos la libreria de estandar input/output
#include <unistd.h> //para hacer sleep
#include <stdlib.h> //para libreria de numeros random: srand, rand 
#include <time.h>   //para inicializar el tiempo

void do_nothing(char* mensaje){
  printf("\n %s \n",mensaje);   
}

void do_nothing_random(char* mensaje){
  printf("\n %s \n",mensaje);   
}

int main() {
  pid_t pid;  //pid del padre
  pid=fork();
  char* msg= "hola";
  if(pid<0){  //error ocurrido
    fprintf(stderr, "Fork failed");
    return 1;
  }
  else if (pid==0){   //si es hijo
    do_nothing_random(msg);
  }
  else{   //si es padre
    do_nothing(msg);
  }
  return 0;
}


 
