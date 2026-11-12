*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Chamada_Steps.robot

Test Setup       Preparar Cenario E Logar    turma_ana_bruno
Test Teardown    Fechar Navegador

*** Test Cases ***
Registrar a chamada do dia com sucesso
    [Documentation]    RF005 (turma 6º Ano A com Ana Souza e Bruno Lima)
    [Tags]    CT009
    Dado que estou na página de chamada da turma "6º Ano A"
    E informei a data "10/11/2026"
    E marquei o aluno "Ana Souza" como "Presente"
    E marquei o aluno "Bruno Lima" como "Ausente"
    Quando clico no botão "Salvar chamada"
    Então o sistema deve exibir a mensagem "Chamada registrada com sucesso"
    E o aluno "Bruno Lima" deve ter 1 falta registrada na turma "6º Ano A"
