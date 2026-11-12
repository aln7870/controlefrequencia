# language: pt
@RF001
Funcionalidade: Realizar login
  Como professor da escola
  Eu quero acessar o sistema com meu e-mail e senha
  Para que eu possa registrar e acompanhar a frequência dos alunos

  Contexto:
    Dado que existe o professor "Carlos Lima" com e-mail "carlos@escola.com" e senha "prof123"
    E que a página de login está acessível

  @CT001 @positivo
  Cenário: Login bem-sucedido com credenciais válidas
    Dado que preenchi o campo de e-mail com "carlos@escola.com"
    E preenchi a senha com "prof123"
    Quando clico no botão "Entrar"
    Então o sistema deve me redirecionar para a "Página Inicial"
    E deve exibir a mensagem de boas-vindas "Olá, Carlos Lima!"

  @CT002 @negativo
  Cenário: Tentativa de login com senha incorreta
    Dado que preenchi o campo de e-mail com "carlos@escola.com"
    E preenchi a senha com "senha_errada"
    Quando clico no botão "Entrar"
    Então o sistema deve exibir a mensagem de erro "E-mail ou senha inválidos"
    E deve permanecer na página de login
