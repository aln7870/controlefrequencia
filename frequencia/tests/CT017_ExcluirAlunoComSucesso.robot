*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    aluno_ana
Test Teardown    Fechar Navegador

*** Test Cases ***
Excluir aluno sem chamadas registradas
    [Documentation]    RF009 (existe a Ana Souza, sem chamadas)
    [Tags]    CT017
    Dado que estou na página "Lista de Alunos"
    Quando clico no botão "Excluir" do aluno "Ana Souza"
    Então o sistema deve exibir a mensagem "Aluno excluído com sucesso"
    E o aluno "Ana Souza" não deve aparecer na lista de alunos
