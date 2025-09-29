*** Settings ***

*** Variables ***
${GREETING}    Olá Mundo!

*** Tasks ***
Greet User
    Log To Console    \n${GREETING}