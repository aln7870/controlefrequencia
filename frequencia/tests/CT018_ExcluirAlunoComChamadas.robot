*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    chamada_editar
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de excluir aluno com chamadas registradas
    [Documentation]    RF009 (a Ana Souza tem chamada registrada em 05/11/2026)
    [Tags]    CT018
    Dado que estou na página "Lista de Alunos"
    Quando clico no botão "Excluir" do aluno "Ana Souza"
    Então o sistema deve exibir a mensagem de erro "Não é possível excluir um aluno com chamadas registradas"
    E o aluno "Ana Souza" deve aparecer na lista de alunos
