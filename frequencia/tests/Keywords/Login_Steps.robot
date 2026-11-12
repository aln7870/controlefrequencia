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
