*** Settings ***
Library     SeleniumLibrary
Library     String
Library     DateTime
Resource    Comum_Steps.robot
Resource    ../Pages/Chamada_Page.robot

*** Keywords ***
# CT009 e CT010 (registrar chamada)
Dado que estou na página de chamada da turma "${turma}"
    Go To    ${URL}/turmas/
    Click Link    ${turma}
    Click Link    Fazer chamada

E informei a data "${data}"
    Preencher Campo    data    ${data}

E informei uma data futura
    [Documentation]    O feature usa 15/11/2026; aqui a data é calculada (hoje + 5 dias) para o teste não vencer.
    ${futura}=    Get Current Date    increment=5 days    result_format=%d/%m/%Y
    Preencher Campo    data    ${futura}

E marquei o aluno "${aluno}" como "${situacao}"
    Selecionar Radio    ${aluno}    ${situacao}

E o aluno "${aluno}" deve ter ${n} falta registrada na turma "${turma}"
    [Documentation]    Confere pela tela de consulta de frequência (RF006).
    Go To    ${URL}/frequencia/
    Preencher Campo    matrícula    ${MATRICULAS}[${aluno}]
    Click Button    xpath=//button[normalize-space()='Consultar']
    Wait Until Page Contains    Faltas: ${n}    timeout=10s

E nenhuma chamada deve ser registrada para a turma "${turma}"
    Dado que estou na página de chamada da turma "${turma}"
    Page Should Not Contain Element    xpath=${LISTA_CHAMADAS}

# CT013 e CT014 (editar chamada)
Dado que estou na página de edição da chamada de "${data}" da turma "${turma}"
    Dado que estou na página de chamada da turma "${turma}"
    Click Link    ${data}

E alterei o aluno "${aluno}" para "${situacao}"
    Selecionar Radio    ${aluno}    ${situacao}

E removi a marcação do aluno "${aluno}"
    [Documentation]    Um botão de rádio não se desmarca pela tela; o script deixa o aluno sem marcação.
    Execute Javascript
    ...    document.querySelectorAll('div.linha').forEach(function(l){ if (l.querySelector('.nome').textContent.trim() === '${aluno}') { l.querySelectorAll('input').forEach(function(i){ i.checked = false; }); } });

E o aluno "${aluno}" deve constar como "${situacao}" na chamada de "${data}"
    Dado que estou na página de edição da chamada de "${data}" da turma "6º Ano A"
    Verificar Situacao Gravada    ${aluno}    ${situacao}

E a chamada de "${data}" deve permanecer sem alterações
    Dado que estou na página de edição da chamada de "${data}" da turma "6º Ano A"
    Verificar Situacao Gravada    Ana Souza     Ausente
    Verificar Situacao Gravada    Bruno Lima    Presente

Verificar Situacao Gravada
    [Arguments]    ${aluno}    ${situacao}
    ${valor}=     Set Variable If    '${situacao}' == 'Presente'    P    A
    ${linha}=     Replace String     ${LINHA_ALUNO}    {}    ${aluno}
    Page Should Contain Element    xpath=${linha}//input[@value='${valor}' and @checked]
