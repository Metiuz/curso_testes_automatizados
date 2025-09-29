*** Settings ***

*** Variables ***
${VERDADE}    ${True}
${SALDO}    ${200}
${VALOR_SAQUE}    ${100}

*** Tasks ***
Condicional:
    IF    ${VALOR_SAQUE} <= ${SALDO}
        # Evaluate serve para atribuir um valor numérico à uma variável.
        ${SALDO}    Evaluate    ${SALDO} - ${VALOR_SAQUE}
        Log To Console    \nSaque realizado. Novo saldo: R$${SALDO}
    ELSE
        Log To Console    \nNão é possivel realizar o saque. Saldo insuficiente!\nSaldo atual: R$${SALDO}
        END
    