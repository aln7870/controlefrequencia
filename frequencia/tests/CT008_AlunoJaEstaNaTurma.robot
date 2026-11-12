*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Cadastro_Steps.robot

Test Setup       Preparar Cenario E Logar    turma_ana_vinculada
Test Teardown    Fechar Navegador

*** Test Cases ***
Tentativa de adicionar um aluno que já está na turma
    [Documentation]    RF004 (a Ana Souza já está na turma 6º Ano A)
    [Tags]    CT008
    Dado que estou na página da turma "6º Ano A"
    E selecionei o aluno "Ana Souza"
    Quando clico no botão "Adicionar à turma"
    Então o sistema deve exibir a mensagem de erro "O aluno já está nesta turma"
    E o aluno "Ana Souza" deve aparecer apenas uma vez na lista da turma
