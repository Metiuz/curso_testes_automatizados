*** Settings ***

*** Variables ***
${NUM}    ${7}

*** Tasks ***
Exercicio 002:
    ${ANTECESSOR}    Evaluate    ${NUM}-1
    ${SUCESSOR}    Evaluate    ${NUM}+1
    Log To Console    \nO número selecionado é o ${NUM}.\nSeu antecessor é o ${ANTECESSOR}.\nE seu sucessor é o ${SUCESSOR}