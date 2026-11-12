*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    turma_com_ana
Test Teardown    Fechar Navegador

*** Test Cases ***
Adicionar aluno à turma com sucesso
    [Documentation]    RF004 (existem a Ana Souza e a turma 6º Ano A)
    [Tags]    CT007
    Dado que estou na página da turma "6º Ano A"
    E selecionei o aluno "Ana Souza"
    Quando clico no botão "Adicionar à turma"
    Então o sistema deve exibir a mensagem "Aluno adicionado à turma com sucesso"
    E o aluno "Ana Souza" deve aparecer na lista de alunos da turma "6º Ano A"
