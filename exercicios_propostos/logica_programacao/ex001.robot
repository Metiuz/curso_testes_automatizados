*** Settings ***

*** Variables ***
${VALOR1}    ${4}
${VALOR2}    ${3}

*** Tasks ***
Exercicio 001:
    Log To Console    \n${VALOR1}+${VALOR2}=${${VALOR1}+${VALOR2}}