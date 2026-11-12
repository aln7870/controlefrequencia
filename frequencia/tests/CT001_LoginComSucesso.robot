*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Login_Steps.robot

Test Setup       Preparar Cenario E Abrir Login    base
Test Teardown    Fechar Navegador

*** Test Cases ***
Login bem-sucedido com credenciais válidas
    [Documentation]    RF001
    [Tags]    CT001
    Dado que preenchi o campo "e-mail" com "carlos@escola.com"
    E preenchi o campo "senha" com "prof123"
    Quando clico no botão "Entrar"
    Então o sistema deve me redirecionar para a "Página Inicial"
    E deve exibir a mensagem de boas-vindas "Olá, Carlos Lima!"
