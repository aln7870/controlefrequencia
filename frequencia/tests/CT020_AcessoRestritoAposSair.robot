*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Login_Steps.robot

Test Setup       Preparar Cenario E Logar    base
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de acessar página restrita após sair
    [Documentation]    RF010 e RN004
    [Tags]    CT020
    Dado que realizei logout do sistema
    Quando tento acessar a página "Lista de Alunos" pela URL
    Então o sistema deve redirecionar para a tela de login
