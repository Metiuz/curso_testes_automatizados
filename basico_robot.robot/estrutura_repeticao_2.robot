*** Settings ***

*** Variables ***
${QTD_LOUCAS_SUJAS}    ${5}

*** Tasks ***
Lavar Louças:
    WHILE    ${QTD_LOUCAS_SUJAS} > 0
        Log To Console    \nLouças sujas restantes: ${QTD_LOUCAS_SUJAS}
        ${QTD_LOUCAS_SUJAS}    Evaluate    ${QTD_LOUCAS_SUJAS} - 1
        
    END
    Log To Console    \nLouça Limpa!