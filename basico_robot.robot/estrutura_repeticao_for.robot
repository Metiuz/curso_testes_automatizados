*** Settings ***

*** Variables ***
${NUMERO}    ${0}

*** Tasks ***
Loop:
    FOR    ${i}    IN RANGE    100
        ${i}    Evaluate    ${i} + 1
        Log To Console    ${i}   
    END
    Log To Console    \nAcabou!