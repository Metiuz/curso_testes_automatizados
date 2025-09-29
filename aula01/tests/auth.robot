*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    JSONLibrary
Suite Setup    Create Session    alias=${SESSION_NAME}    url=${BASE_URL}
Resource    ../resources/environment.resource
Resource    ../resources/keywords.resource

*** Test Cases ***

TC1: realizar autenticação com usuário válido  
    [Tags]    valid
    ${response}    POST /auth    PostAuthValid.json   200
    Validate Json    ${response}    CreateTokenValid.json

TC2: realizar autenticação com usuário inválido
    ${response}    POST /auth    PostAuthInvalid.json   200
    Validate Json    ${response}    CreateTokenInvalid.json