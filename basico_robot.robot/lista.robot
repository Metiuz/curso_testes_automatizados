*** Settings ***

*** Variables ***
@{LISTA_VEICULOS}    carro    moto    onibus    caminhão    

*** Tasks ***
Lista 01:
    Log To Console    \nPrimeiro item é: ${LISTA_VEICULOS}[0]
    FOR    ${VEICULO}    IN    @{LISTA_VEICULOS}
        Log To Console    Veiculo: ${VEICULO}
        
    END
    ${tamanho} =    Get Length    ${LISTA_VEICULOS}
    Log To Console    \nComprimento da lista:${tamanho}
    