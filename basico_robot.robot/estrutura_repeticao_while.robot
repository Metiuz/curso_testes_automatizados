*** Settings ***

*** Variables ***
${NUMERO}    ${0}

*** Tasks ***
Loop:
    WHILE    ${NUMERO} < 100
        ${NUMERO}    Evaluate    ${NUMERO} + 1
        Log To Console    ${NUMERO}
    END
    Log To Console    \nAcabou!