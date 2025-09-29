*** Settings ***

*** Variables ***
${NOME}    Matheus
${SENHA}    123

*** Tasks ***
Fazer Login:
    IF    "${NOME}" == "Matheus" and "${SENHA}" == "123"
        Log To Console    \nLogado com Sucesso!
    ELSE
        Log To Console    \nUsuário ou Senha incorreto.
    END
    