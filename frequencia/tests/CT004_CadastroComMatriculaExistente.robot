*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    aluno_ana
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de cadastro com matrícula já existente
    [Documentation]    RF002 (já existe a Ana Souza, matrícula 2026001)
    [Tags]    CT004
    Dado que estou na página "Cadastro de Aluno"
    E preenchi o campo "nome" com "Bruno Lima"
    E preenchi o campo "matrícula" com "2026001"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem de erro "Já existe um aluno com esta matrícula"
    E o aluno "Bruno Lima" não deve aparecer na lista de alunos
