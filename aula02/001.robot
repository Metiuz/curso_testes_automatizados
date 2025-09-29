*** Settings ***
Library    SeleniumLibrary

Test Setup    Abrir navegador
# Test Teardown    Close Browser

*** Variables ***
${URL}    https://www.saucedemo.com/v1/
${BROWSER}    firefox
${NOME}    Matheus
${SOBRENOME}    Rangel Ribeiro
${CEP}    26185570
&{LOGINPAGE}
...    INPUT_LOGIN=id:user-name
...    INPUT_SENHA=id:password
...    SUBMIT=id:login-button
...    LOGIN=standard_user
...    LOGIN_INVALIDO=locked_out_user
...    LOGIN_PERFORMANCE=performance_glitch_user
...    SENHA=secret_sauce
...    ERROR_MESSAGE=xpath://*[@id="login_button_container"]/div/form/h3/button

&{BUYPAGE}
...    PRIMEIRO_PRODUTO=xpath://*[@id="inventory_container"]/div/div[1]/div[3]/button
...    SEGUNDO_PRODUTO=xpath://*[@id="inventory_container"]/div/div[2]/div[3]/button
...    BOTAO_CARRINHO=xpath://*[@id="shopping_cart_container"]/a

&{CARPAGE}
...    CHECKOUT_BUTTON=xpath://*[@id="cart_contents_container"]/div/div[2]/a[2]

&{CHECKOUTPAGE}
...    NOME=id:first-name
...    SOBRENOME=id:last-name
...    CEP=id:postal-code
...    CONTINUE_BUTTON=xpath://*[@id="checkout_info_container"]/div/form/div[2]/input
...    FINISH_BUTTON=xpath:/html/body/div/div[2]/div[3]/div/div[2]/div[8]/a[2]

*** Keywords ***

Abrir navegador
    Open Browser    url=${URL}    browser=${BROWSER}
    Maximize Browser Window

Verificar se conseguiu realizar o login corretamente
    ${CURURL}    Get Location
    Should Contain    container=${CURURL}    item=/inventory.html

Verificar se não foi possível realizar o login
    ${MENSAGEM_OBTIDA}    Get Text    locator=${LOGINPAGE.ERROR_MESSAGE}
    ${MENSAGEM_ESPERADA}    Set Variable    Epic sadface: Sorry, this user has been locked out.
    Should Be Equal    first=${MENSAGEM_OBTIDA}    second=${MENSAGEM_ESPERADA}

Verificar se acessou carrinho
    ${CURURL}    Get Location
    Should Contain    container=${CURURL}    item=/cart.html

Verificar se acessou checkout
    ${CURURL}    Get Location
    Should Contain    container=${CURURL}    item=/checkout-step-one.html

Verificar se acessou checkout 2
    ${CURURL}    Get Location
    Should Contain    container=${CURURL}    item=/checkout-step-two.html

Verificar se comprou com sucesso
    ${CURURL}    Get Location
    Should Contain    container=${CURURL}    item=/checkout-complete.html

Realizar login com ${USERNAME} e ${PASSWORD}
    Wait Until Element Is Visible    locator=${LOGINPAGE.INPUT_LOGIN}
    Input Text    locator=${LOGINPAGE.INPUT_LOGIN}    text=${USERNAME}

    Wait Until Element Is Visible    locator=${LOGINPAGE.INPUT_SENHA}
    Input Text    locator=${LOGINPAGE.INPUT_SENHA}    text=${PASSWORD}

    Wait Until Element Is Visible    locator=${LOGINPAGE.SUBMIT}
    Click Element    locator=${LOGINPAGE.SUBMIT}

Realizar checkout com ${firstname}, ${lastname} e {cep}
    Wait Until Element Is Visible    locator=${CHECKOUTPAGE.NOME}
    Input Text    locator=${CHECKOUTPAGE.NOME}    text=${firstname}

    Wait Until Element Is Visible    locator=${CHECKOUTPAGE.SOBRENOME}
    Input Text    locator=${CHECKOUTPAGE.SOBRENOME}    text=${lastname}

    Wait Until Element Is Visible    locator=${CHECKOUTPAGE.CEP}
    Input Text    locator=${CHECKOUTPAGE.CEP}    text=${cep}

    Wait Until Element Is Visible    locator=${CHECKOUTPAGE.CONTINUE_BUTTON}
    Click Element    locator=${CHECKOUTPAGE.CONTINUE_BUTTON}

*** Test Cases ***
TC001 - Realizar login válido
    [Tags]    Fluxo-Positivo    REQ001
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Sleep    time_=2s

TC002 - Realizar login inválido
    [Tags]    Fluxo-Negativo    REQ002
    Realizar login com ${LOGINPAGE.LOGIN_INVALIDO} e ${LOGINPAGE.SENHA}
    Sleep    time_=2s

TC003 - Realizar compra com baixa performance
    [Tags]    Tarefa001
    Realizar login com ${LOGINPAGE.LOGIN_PERFORMANCE} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente

    Wait Until Element Is Visible    locator=${BUYPAGE.PRIMEIRO_PRODUTO}
    Click Element    locator=${BUYPAGE.PRIMEIRO_PRODUTO}
    Wait Until Element Is Visible    locator=${BUYPAGE.SEGUNDO_PRODUTO}
    Click Element    locator=${BUYPAGE.SEGUNDO_PRODUTO}
    Wait Until Element Is Visible    locator=${BUYPAGE.BOTAO_CARRINHO}
    Click Element    locator=${BUYPAGE.BOTAO_CARRINHO}

    Verificar se acessou carrinho
    Sleep    time_=4s

    Wait Until Element Is Visible    locator=${CARPAGE.CHECKOUT_BUTTON}
    Click Element    locator=${CARPAGE.CHECKOUT_BUTTON}

    Verificar se acessou checkout
    Realizar checkout com ${NOME}, ${SOBRENOME} e {CEP}


    Sleep    time_=2s
    Verificar se acessou checkout 2
    Wait Until Element Is Visible    locator=${CHECKOUTPAGE.FINISH_BUTTON}
    Click Element    locator=${CHECKOUTPAGE.FINISH_BUTTON}

    Verificar se comprou com sucesso

