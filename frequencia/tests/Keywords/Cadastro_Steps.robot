*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    Comum_Steps.robot
Resource    ../Pages/Cadastro_Page.robot

*** Keywords ***
# CT003 e CT004 (aluno)
E o aluno "${nome}" deve aparecer na lista de alunos
    Go To    ${URL}/alunos/
    Page Should Contain    ${nome}

E o aluno "${nome}" não deve aparecer na lista de alunos
    Go To    ${URL}/alunos/
    Page Should Not Contain    ${nome}

# CT005 e CT006 (turma)
E selecionei o turno "${turno}"
    Select From List By Label    xpath=${SELECT_TURNO}    ${turno}

E deixei o campo nome vazio
    Clear Element Text    name=nome

E a turma "${nome}" deve aparecer na lista de turmas
    Go To    ${URL}/turmas/
    Page Should Contain    ${nome}

E nenhuma nova turma deve ser cadastrada
    Go To    ${URL}/turmas/
    Page Should Contain    Nenhuma turma cadastrada

# CT007 e CT008 (vincular aluno à turma)
Dado que estou na página da turma "${turma}"
    Go To    ${URL}/turmas/
    Click Link    ${turma}

E selecionei o aluno "${aluno}"
    Select From List By Label    xpath=${SELECT_ALUNO}    ${aluno}

E o aluno "${aluno}" deve aparecer na lista de alunos da turma "${turma}"
    ${item}=    Replace String    ${ITEM_ALUNO_DA_TURMA}    {}    ${aluno}
    Page Should Contain Element    xpath=${item}

E o aluno "${aluno}" deve aparecer apenas uma vez na lista da turma
    ${item}=    Replace String    ${ITEM_ALUNO_DA_TURMA}    {}    ${aluno}
    Page Should Contain Element    xpath=${item}    limit=1
