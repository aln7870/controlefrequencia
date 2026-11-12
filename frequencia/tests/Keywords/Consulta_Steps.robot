*** Settings ***
Library     SeleniumLibrary
Resource    Comum_Steps.robot
Resource    ../Pages/Consulta_Page.robot

*** Keywords ***
# CT011 e CT012 (consultar frequência)
Então o sistema deve exibir o total de "${total}" aulas, "${presencas}" presenças e "${faltas}" faltas
    Wait Until Page Contains    Total de aulas: ${total}    timeout=10s
    Page Should Contain    Presenças: ${presencas}
    Page Should Contain    Faltas: ${faltas}

E deve exibir a frequência "${percentual}"
    Page Should Contain    Frequência: ${percentual}

E deve exibir a situação "${situacao}"
    Page Should Contain    Situação: ${situacao}

E nenhum dado de frequência deve ser exibido
    Page Should Not Contain    Total de aulas

# CT015 e CT016 (excesso de faltas)
E selecionei a turma "${turma}"
    Select From List By Label    xpath=${SELECT_TURMA}    ${turma}

Então o sistema deve exibir o aluno "${aluno}" com frequência "${percentual}"
    Wait Until Page Contains    ${aluno} — ${percentual}    timeout=10s

E não deve exibir o aluno "${aluno}"
    Page Should Not Contain    ${aluno}

E nenhum aluno deve ser listado
    Page Should Not Contain Element    xpath=${ALUNO_EM_RISCO}
