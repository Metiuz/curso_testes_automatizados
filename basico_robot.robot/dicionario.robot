*** Settings ***

*** Variables ***
&{DICIONARIO}    chave1=valor1    chave2=valor2

*** Tasks ***
Dicionario:
    FOR    ${chave}    IN    @{DICIONARIO}
        Log To Console    \nchave: ${chave} e valor: ${DICIONARIO["${chave}"]}
    END
    