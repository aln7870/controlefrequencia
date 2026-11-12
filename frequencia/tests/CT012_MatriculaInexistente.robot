*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Consulta_Steps.robot

Test Setup       Preparar Cenario E Logar    frequencia_ana
Test Teardown    Fechar Navegador

*** Test Cases ***
Consultar frequência com matrícula inexistente
    [Documentation]    RF006
    [Tags]    CT012
    Dado que estou na página "Consultar Frequência"
    E preenchi o campo "matrícula" com "9999999"
    Quando clico no botão "Consultar"
    Então o sistema deve exibir a mensagem de erro "Aluno não encontrado"
    E nenhum dado de frequência deve ser exibido
