*** Settings ***
Resource    Keywords/Comum_Steps.robot
Resource    Keywords/Chamada_Steps.robot

Test Setup       Preparar Cenario E Logar    chamada_editar
Test Teardown    Fechar Navegador

*** Test Cases ***
Corrigir a situação de um aluno na chamada
    [Documentation]    RF007 (chamada de 05/11/2026: Ana ausente, Bruno presente)
    [Tags]    CT013
    Dado que estou na página de edição da chamada de "05/11/2026" da turma "6º Ano A"
    E alterei o aluno "Ana Souza" para "Presente"
    Quando clico no botão "Salvar alterações"
    Então o sistema deve exibir a mensagem "Chamada atualizada com sucesso"
    E o aluno "Ana Souza" deve constar como "Presente" na chamada de "05/11/2026"
