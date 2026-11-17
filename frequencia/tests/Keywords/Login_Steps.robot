*** Settings ***
Library     SeleniumLibrary
Resource    Comum_Steps.robot
Resource    ../Pages/Login_Page.robot

*** Keywords ***
# CT001 e CT002
Então o sistema deve me redirecionar para a "${pagina}"
    Wait Until Location Is    ${URL}/inicio/    timeout=10s
    Element Text Should Be    xpath=${TITULO_PAGINA_INICIAL}    ${pagina}

E deve exibir a mensagem de boas-vindas "${mensagem}"
    Page Should Contain    ${mensagem}

E deve permanecer na página de login
    Location Should Be    ${URL}/login/

# CT019 e CT020 (sair do sistema)
Quando clico no link "${texto}"
    Click Link    ${texto}

E deve exibir a tela de login
    Wait Until Location Is    ${URL}/login/    timeout=10s

Dado que realizei logout do sistema
    Click Link    Sair
    Wait Until Location Is    ${URL}/login/    timeout=10s

Quando tento acessar a página "${nome}" pela URL
    Go To    ${URL}${PAGINAS}[${nome}]

Então o sistema deve redirecionar para a tela de login
    Wait Until Location Is    ${URL}/login/    timeout=10s
