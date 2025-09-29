*** Settings ***

*** Variables ***
${NOME_ALUNO}    Matheus
${DISCIPLINA}    Teste Automatizado
@{NOTAS}    ${8}    ${10}    ${7}    ${7}
${TOTAL_NOTA}    ${0}

*** Tasks ***
Exercicio 003:
    ${QTT_NOTAS}    Get Length    ${NOTAS}
    Log To Console    \nO aluno ${NOME_ALUNO}, na disciplina ${DISCIPLINA} teve as seguintes notas:
    FOR    ${NOTA}    IN    @{NOTAS}
        Log To Console    ${NOTA}
        ${TOTAL_NOTA}    Evaluate    ${TOTAL_NOTA}+${NOTA}
    END
    Log To Console    \nE de média na disciplina ele obteve: ${${TOTAL_NOTA}/${QTT_NOTAS}}
    