*** Settings ***

*** Variables ***
${ANO_NASCIMENTO}    ${2000}
${ANO_FUTURO}    ${2035}

*** Tasks ***
Exercicio 004:
    ${RESULTADO}    Evaluate    ${ANO_FUTURO} - ${ANO_NASCIMENTO}
    Log To Console    \nJá que você nasceu no ano ${ANO_NASCIMENTO}.\nEm ${ANO_FUTURO} você terá ${RESULTADO} anos de idade.