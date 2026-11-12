*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Login_Steps.robot

Test Setup       Preparar Cenario E Abrir Login    base
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de login com senha incorreta
    [Documentation]    RF001
    [Tags]    CT002
    Dado que preenchi o campo "e-mail" com "carlos@escola.com"
    E preenchi o campo "senha" com "senha_errada"
    Quando clico no botão "Entrar"
    Então o sistema deve exibir a mensagem de erro "E-mail ou senha inválidos"
    E deve permanecer na página de login
