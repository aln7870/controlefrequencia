*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    base
Test Teardown    Fechar Navegador

*** Test Cases ***
Cadastro de aluno com dados válidos
    [Documentation]    RF002
    [Tags]    CT003
    Dado que estou na página "Cadastro de Aluno"
    E preenchi o campo "nome" com "Ana Souza"
    E preenchi o campo "matrícula" com "2026001"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem "Aluno cadastrado com sucesso"
    E o aluno "Ana Souza" deve aparecer na lista de alunos
