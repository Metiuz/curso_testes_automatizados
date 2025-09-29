*** Settings ***

*** Variables ***
${NOME}    Matheus
${IDADE}    25
${ALTURA}    1.83
${PESO}    96
${ESTADO_CIVIL}    S

*** Tasks ***
Exemplos Variáveis 02:
    Log To Console    \nNome: ${NOME} \nIdade: ${IDADE} \nAltura: ${ALTURA} \nPeso: ${PESO} \nEstado Civil: ${ESTADO_CIVIL}