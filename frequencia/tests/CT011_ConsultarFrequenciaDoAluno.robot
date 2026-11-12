*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Consulta_Steps.robot

Test Setup       Preparar Cenario E Logar    frequencia_ana
Test Teardown    Fechar Navegador

*** Test Cases ***
Consultar frequência de um aluno existente
    [Documentation]    RF006 (Ana Souza, 2026001: 8 presenças e 2 faltas)
    [Tags]    CT011
    Dado que estou na página "Consultar Frequência"
    E preenchi o campo "matrícula" com "2026001"
    Quando clico no botão "Consultar"
    Então o sistema deve exibir o total de "10" aulas, "8" presenças e "2" faltas
    E deve exibir a frequência "80%"
    E deve exibir a situação "Regular"
