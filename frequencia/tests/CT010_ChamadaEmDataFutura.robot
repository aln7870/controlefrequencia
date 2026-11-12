*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Chamada_Steps.robot

Test Setup       Preparar Cenario E Logar    turma_ana_bruno
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de registrar chamada em data futura
    [Documentation]    RF005
    [Tags]    CT010
    Dado que estou na página de chamada da turma "6º Ano A"
    E informei uma data futura
    E marquei o aluno "Ana Souza" como "Presente"
    E marquei o aluno "Bruno Lima" como "Presente"
    Quando clico no botão "Salvar chamada"
    Então o sistema deve exibir a mensagem de erro "Não é permitido registrar chamada em data futura"
    E nenhuma chamada deve ser registrada para a turma "6º Ano A"
