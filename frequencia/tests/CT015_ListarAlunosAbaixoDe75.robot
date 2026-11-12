*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Consulta_Steps.robot

Test Setup       Preparar Cenario E Logar    excesso_de_faltas
Test Teardown    Fechar Navegador

*** Test Cases ***
Listar alunos abaixo de 75% de frequência
    [Documentation]    RF008 (6º Ano A: Ana 90% e Bruno 60%)
    [Tags]    CT015
    Dado que estou na página "Alunos com Excesso de Faltas"
    E selecionei a turma "6º Ano A"
    Quando clico no botão "Gerar lista"
    Então o sistema deve exibir o aluno "Bruno Lima" com frequência "60%"
    E não deve exibir o aluno "Ana Souza"
