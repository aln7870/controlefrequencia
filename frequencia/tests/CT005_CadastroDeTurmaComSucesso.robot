*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    base
Test Teardown    Fechar Navegador

*** Test Cases ***
Cadastro de turma com dados válidos
    [Documentation]    RF003
    [Tags]    CT005
    Dado que estou na página "Cadastro de Turma"
    E preenchi o campo "nome" com "6º Ano A"
    E preenchi o campo "ano letivo" com "2026"
    E selecionei o turno "Manhã"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem "Turma cadastrada com sucesso"
    E a turma "6º Ano A" deve aparecer na lista de turmas
