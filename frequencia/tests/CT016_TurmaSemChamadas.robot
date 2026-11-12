*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Consulta_Steps.robot

Test Setup       Preparar Cenario E Logar    excesso_de_faltas
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de gerar a lista para turma sem chamadas registradas
    [Documentation]    RF008 (a turma 7º Ano B não tem chamadas)
    [Tags]    CT016
    Dado que estou na página "Alunos com Excesso de Faltas"
    E selecionei a turma "7º Ano B"
    Quando clico no botão "Gerar lista"
    Então o sistema deve exibir a mensagem "Nenhuma chamada registrada para esta turma"
    E nenhum aluno deve ser listado
