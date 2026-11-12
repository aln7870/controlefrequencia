*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    base
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de cadastro de turma sem nome
    [Documentation]    RF003
    [Tags]    CT006
    Dado que estou na página "Cadastro de Turma"
    E deixei o campo nome vazio
    E preenchi o campo "ano letivo" com "2026"
    E selecionei o turno "Manhã"
    Quando clico no botão "Salvar"
    Então o sistema deve exibir a mensagem de erro "O nome da turma é obrigatório"
    E nenhuma nova turma deve ser cadastrada
