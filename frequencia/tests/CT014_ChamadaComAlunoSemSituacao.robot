*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Chamada_Steps.robot

Test Setup       Preparar Cenario E Logar    chamada_editar
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de salvar a chamada com aluno sem situação marcada
    [Documentation]    RF007
    [Tags]    CT014
    Dado que estou na página de edição da chamada de "05/11/2026" da turma "6º Ano A"
    E removi a marcação do aluno "Bruno Lima"
    Quando clico no botão "Salvar alterações"
    Então o sistema deve exibir a mensagem de erro "Informe a presença de todos os alunos"
    E a chamada de "05/11/2026" deve permanecer sem alterações
