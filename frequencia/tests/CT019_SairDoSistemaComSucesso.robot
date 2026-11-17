*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Login_Steps.robot

Test Setup       Preparar Cenario E Logar    base
Test Teardown    Fechar Navegador

*** Test Cases ***
Sair do sistema com sucesso
    [Documentation]    RF010
    [Tags]    CT019
    Dado que estou na página "Lista de Alunos"
    Quando clico no link "Sair"
    Então o sistema deve exibir a mensagem "Você saiu do sistema"
    E deve exibir a tela de login
