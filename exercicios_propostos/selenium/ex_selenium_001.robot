*** Settings ***
Library    SeleniumLibrary

Test Setup    Abrir navegador
Test Teardown    Close Browser

*** Variables ***
${URL}    https://www.saucedemo.com/v1/
${BROWSER}    firefox
&{LOGINPAGE}
...    INPUT_LOGIN=id:user-name
...    INPUT_SENHA=id:password
...    SUBMIT=id:login-button
...    LOGIN=standard_user
...    LOGIN_INVALIDO=locked_out_user
...    SENHA=secret_sauce
...    ERROR_MESSAGE=xpath://*[@id="login_button_container"]/div/form/h3/button

&{INVENTORYPAGE}
...    ITEM4_BUTTON=xpath://*[@id="inventory_container"]/div/div[1]/div[3]/button
...    ITEM0_BUTTON=xpath://*[@id="inventory_container"]/div/div[2]/div[3]/button
...    ITEM1_BUTTON=xpath://*[@id="inventory_container"]/div/div[3]/div[3]/button
...    ITEM5_BUTTON=xpath://*[@id="inventory_container"]/div/div[4]/div[3]/button
...    ITEM2_BUTTON=xpath://*[@id="inventory_container"]/div/div[5]/div[3]/button
...    ITEM3_BUTTON=xpath://*[@id="inventory_container"]/div/div[6]/div[3]/button
...    ITEM4_NAME=xpath://*[@id="item_4_title_link"]/div
...    ITEM0_NAME=xpath://*[@id="item_0_title_link"]/div
...    ITEM1_NAME=xpath://*[@id="item_1_title_link"]/div
...    ITEM5_NAME=xpath://*[@id="item_5_title_link"]/div
...    ITEM2_NAME=xpath://*[@id="item_2_title_link"]/div
...    ITEM3_NAME=xpath://*[@id="item_3_title_link"]/div
...    STOCKED_ITEMS=xpath://*[@id="shopping_cart_container"]/a/span
...    DROPDOWN=xpath://*[@id="inventory_filter_container"]/select
...    LIST_VALUE_A_Z=xpath://*[@id="inventory_filter_container"]/select/option[1]
...    LIST_VALUE_Z_A=xpath://*[@id="inventory_filter_container"]/select/option[2]
...    BACK_BUTTON=xpath://*[@id="inventory_item_container"]/div/button

*** Keywords ***

Abrir navegador
    Open Browser    url=${URL}    browser=${BROWSER}
    Maximize Browser Window

Verificar se conseguiu realizar o login corretamente
    ${CURURL}    Get Location
    Should Contain    container=${CURURL}    item=/inventory.html

Verificar se selecionou corretamente o item ${Num_item}
    ${CURURL}    Get Location
    Should Contain    container=${CURURL}    item=/inventory-item.html?id=${Num_item}

Verificar se não foi possível realizar o login
    ${MENSAGEM_OBTIDA}    Get Text    locator=${LOGINPAGE.ERROR_MESSAGE}
    ${MENSAGEM_ESPERADA}    Set Variable    Epic sadface: Sorry, this user has been locked out.
    Should Be Equal    first=${MENSAGEM_OBTIDA}    second=${MENSAGEM_ESPERADA}

Realizar login com ${USERNAME} e ${PASSWORD}
    Wait Until Element Is Visible    locator=${LOGINPAGE.INPUT_LOGIN}
    Input Text    locator=${LOGINPAGE.INPUT_LOGIN}    text=${USERNAME}

    Wait Until Element Is Visible    locator=${LOGINPAGE.INPUT_SENHA}
    Input Text    locator=${LOGINPAGE.INPUT_SENHA}    text=${PASSWORD}

    Wait Until Element Is Visible    locator=${LOGINPAGE.SUBMIT}
    Click Element    locator=${LOGINPAGE.SUBMIT}

Verificar a ${quantidade} de itens selecionados
    ${qtt_selected}    Get Text    locator=${INVENTORYPAGE.STOCKED_ITEMS}
    Should Be Equal    first=${qtt_selected}    second=${quantidade}

*** Test Cases ***
Cenário 1: Adicionar vários itens ao carrinho
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM3_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM3_BUTTON}
    Verificar a 3 de itens selecionados
    Sleep    time_=3s
    

Cenário 2: Ordenar os itens de A a Z
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.DROPDOWN}
    Click Element    locator=${INVENTORYPAGE.DROPDOWN}
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.LIST_VALUE_A_Z}
    Click Element    locator=${INVENTORYPAGE.LIST_VALUE_A_Z}
    Sleep    time_=3s

Cenário 3: Ordenar os itens de Z a A
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.DROPDOWN}
    Click Element    locator=${INVENTORYPAGE.DROPDOWN}
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.LIST_VALUE_Z_A}
    Click Element    locator=${INVENTORYPAGE.LIST_VALUE_Z_A}
    Sleep    time_=3s

Cenário 4: Verificar detalhes de vários produtos
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM1_NAME}
    Click Element    locator=${INVENTORYPAGE.ITEM1_NAME}
    Verificar se selecionou corretamente o item 1
    Sleep    time_=2s

Cenário 5: Verificar detalhes do segundo produto
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM2_NAME}
    Click Element    locator=${INVENTORYPAGE.ITEM2_NAME}
    Verificar se selecionou corretamente o item 2
    Sleep    time_=2s

Cenário 6: Remover vários itens do carrinho
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM3_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM3_BUTTON}
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Verificar a 1 de itens selecionados
    Sleep    time_=2s

Cenário 7: Filtrar produtos pela categoria
    #NÃO É POSSIVEL LOCALIZAR O BOTÃO DE CATEGORIA "T-SHIRTS"
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
Cenário 8: Verificar a persistência do estado do carrinho após navegação
    Realizar login com ${LOGINPAGE.LOGIN} e ${LOGINPAGE.SENHA}
    Verificar se conseguiu realizar o login corretamente
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM1_BUTTON}
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Click Element    locator=${INVENTORYPAGE.ITEM2_BUTTON}
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.ITEM1_NAME}
    Click Element    locator=${INVENTORYPAGE.ITEM1_NAME}
    Verificar se selecionou corretamente o item 1
    Sleep    time_=2s
    Wait Until Element Is Visible    locator=${INVENTORYPAGE.BACK_BUTTON}
    Click Element    locator=${INVENTORYPAGE.BACK_BUTTON}
    Verificar a 2 de itens selecionados
    Sleep    time_=2s

