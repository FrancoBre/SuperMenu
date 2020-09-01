#include <stdio.h>
#include <stdlib.h>    
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

sem_t sem1;
sem_t sem2;
sem_t sem3;
sem_t sem4;

void funcion1(){
    printf("Pienso\n");
    sem_post(&sem1);
    sem_post(&sem1);
    sem_post(&sem1);
    sem_post(&sem2);
}

void funcion2(){
    sem_wait(&sem1);
    printf("Mientras lavo los platos, ");
    //sem_post(&sem1);
}

void funcion3(){
    sem_wait(&sem1);
    printf("Mientras limpio el piso, ");
    //sem_post(&sem1);
}

void funcion4(){
    sem_wait(&sem1);
    printf("Mientras riego las plantas\n");
    //sem_post(&sem1);
}

void funcion5(){
    sem_wait(&sem2);
    printf("Existo!\n");
    sem_post(&sem3);
    sem_post(&sem3);
}

void funcion6(){
    sem_wait(&sem3);
    printf("Hablar\n");
    //sem_post(&sem2);
}

void funcion7(){
    sem_wait(&sem3);
    printf("Tomar una decisión\n");
    //sem_post(&sem2);
}

int main(int argc, char *argv[]){
    if(argc < 2){
        printf("Debe pasar un número como parámetro\n");
        return 1;
    }

    long num= strtol(argv[1], NULL, 10);

    if(num<1){
        printf("El número debe ser por lo menos 1\n");
        return 2;
    }
    pthread_t thread1, thread2, thread3, thread4, thread5, thread6, thread7;  
    for(int i=0; i<num; i++){
        sem_init(&sem1, 0, 0);
        sem_init(&sem2, 0, 0);
        sem_init(&sem3, 0, 0);
        printf("%i) ",i+1);
        pthread_create(&thread1, NULL, (void*) funcion1, (void*) NULL);
        pthread_create(&thread2, NULL, (void*) funcion2, (void*) NULL);
        pthread_create(&thread3, NULL, (void*) funcion3, (void*) NULL);
        pthread_create(&thread4, NULL, (void*) funcion4, (void*) NULL);
        sleep(1);
        pthread_create(&thread5, NULL, (void*) funcion5, (void*) NULL);
        pthread_create(&thread6, NULL, (void*) funcion6, (void*) NULL);
        pthread_create(&thread7, NULL, (void*) funcion7, (void*) NULL);
        pthread_join(thread1, NULL);
        pthread_join(thread2, NULL);
        pthread_join(thread3, NULL);
        pthread_join(thread4, NULL);
        pthread_join(thread5, NULL);
        pthread_join(thread6, NULL);
        pthread_join(thread7, NULL);
        sem_destroy(&sem1);
        sem_destroy(&sem2);
        sem_destroy(&sem3);
        printf("\n");
    }
    return 0;
}