*** Settings ***
Library     SeleniumLibrary
Library     Process
Library     String
Library     DateTime
Resource    ../Pages/Comum_Page.robot

*** Variables ***
${PROJETO}    ${CURDIR}${/}..${/}..${/}..

*** Keywords ***
# ========== GLOBAIS =============== #
Preparar Cenario
    [Documentation]    Monta os dados do cenário no banco (veja management/commands/preparar_testes.py).
    [Arguments]    ${cenario}
    ${r}=    Run Process    ${PYTHON}    manage.py    preparar_testes    ${cenario}    cwd=${PROJETO}
    Should Be Equal As Integers    ${r.rc}    0    msg=${r.stderr}

Abrir tela de login
    Open Browser    ${URL}/login/    ${BROWSER}    options=${OPTIONS}    executable_path=${DRIVER}
    Maximize Browser Window
    Set Selenium Speed    ${SPEED}

Fechar Navegador
    Close Browser

Preparar Cenario E Abrir Login
    [Arguments]    ${cenario}
    Preparar Cenario    ${cenario}
    Abrir tela de login

Preparar Cenario E Logar
    [Arguments]    ${cenario}
    Preparar Cenario E Abrir Login    ${cenario}
    Input Text      name=email    carlos@escola.com
    Input Text      name=senha    prof123
    Click Button    xpath=//button[normalize-space()='Entrar']
    Wait Until Page Contains    Página Inicial    timeout=10s

Preencher Campo
    [Arguments]    ${campo}    ${valor}
    ${nome}=    Set Variable    ${CAMPOS}[${campo}]
    Clear Element Text    name=${nome}
    Input Text            name=${nome}    ${valor}

Selecionar Radio
    [Arguments]    ${aluno}    ${situacao}
    ${valor}=      Set Variable If    '${situacao}' == 'Presente'    P    A
    ${linha}=      Replace String     ${LINHA_ALUNO}    {}    ${aluno}
    Click Element    xpath=${linha}//input[@value='${valor}']

# ========== PASSOS REUTILIZADOS =============== #
Dado que estou na página "${nome}"
    Go To    ${URL}${PAGINAS}[${nome}]

Dado que preenchi o campo "${campo}" com "${valor}"
    Preencher Campo    ${campo}    ${valor}

E preenchi o campo "${campo}" com "${valor}"
    Preencher Campo    ${campo}    ${valor}

Quando clico no botão "${botao}"
    Click Button    xpath=//button[normalize-space()='${botao}']

Então o sistema deve exibir a mensagem "${mensagem}"
    Wait Until Page Contains    ${mensagem}    timeout=10s

Então o sistema deve exibir a mensagem de erro "${mensagem}"
    Wait Until Page Contains    ${mensagem}    timeout=10s
