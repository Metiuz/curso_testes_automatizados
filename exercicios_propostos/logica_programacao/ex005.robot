*** Settings ***

*** Variables ***
${VALOR_HORA_NORMAL}    ${10.00}
${VALOR_HORA_EXTRA}    ${15.00}
${TOTAL_HORA_NORMAL_TRABALHADA}    ${1760}
${TOTAL_HORA_EXTRA_TRABALHADA}    ${400}

*** Tasks ***
Exercicio 005:
    ${SALARIO_ANUAL}    Evaluate    ${VALOR_HORA_NORMAL}*${TOTAL_HORA_NORMAL_TRABALHADA} + ${VALOR_HORA_EXTRA}*${TOTAL_HORA_EXTRA_TRABALHADA}
    Log To Console    \nHoras trabalhadas no ano: ${TOTAL_HORA_NORMAL_TRABALHADA}\nHoras extras trabalhadas no ano: ${TOTAL_HORA_EXTRA_TRABALHADA}\nSeu salário anual é de R$${SALARIO_ANUAL}